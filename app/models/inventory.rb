class Inventory < ApplicationRecord
	belongs_to :purchase_product, optional: true
  belongs_to :product
  belongs_to :purchase, optional: true
  belongs_to :production, optional: true
	after_create :set_remaining_quantity
  before_create :set_cost_per_unit



  attr_accessor :purchase_quantity

  def set_remaining_quantity

    if production_id.blank? && purchase_id.blank?
        self.remaining_quantity = remaining_quantity

    elsif !production_id.blank?
        self.remaining_quantity = remaining_quantity
    
    elsif purchase_product.purchase_quantity.blank?
        self.remaining_quantity = nil

    elsif !purchase_product.purchase_quantity.blank?
        self.remaining_quantity = purchase_product.purchase_quantity 
    end
    
  end

  # takes an array of product_ids and returns a hash of the amount left in inventory
  def self.get_amounts_for(product_ids)

    sql = """
            SELECT product_id, (remaining_quantity*grams_per_unit) AS amount_available_in_grams
            FROM inventories 
            INNER JOIN products ON product_id = products.id
            WHERE product_id IN (#{SqlHelper.escape_sql_param product_ids})
          
          """

    results = ActiveRecord::Base.connection.execute(sql)  
    amounts_left = {}
    results.each do |row|
      amounts_left[row['product_id'].to_i] = row['amount_available_in_grams']
    end
  end

  #adds a new inventory from Productions
  def self.add_inventory(production_id, product_id, production_yield, production_total_cost)

    cost_per_unit = production_total_cost / production_yield
    inv = Inventory.create(production_id: production_id, product_id: product_id, 
    remaining_quantity: production_yield, cost_per_unit: cost_per_unit)    
  end

  #adds a new inventory from a cancelled Order
  def self.return_inventory(product_id, order_id, amount_to_put_back, cost_per_unit)
    inv = Inventory.create(product_id: product_id, remaining_quantity: amount_to_put_back, cost_per_unit: cost_per_unit) 
  end

  #removes inventory when they are used up by a Production 
  def self.remove_used_inventory(product_id, usage_amount)
    
    
      return if usage_amount.nil? || usage_amount == 0

      inventories = Inventory.where("product_id = ? and remaining_quantity > 0", product_id).order("created_at asc")
      amount_left_to_remove = usage_amount

      inventories.each do |sp|
        
          #converts remaining units to remaining grams
          sp.remaining_quantity = sp.remaining_quantity * sp.product.grams_per_unit
          #sets remaining amount equalt to remaining amount for the oldest record in the database
          amount_to_remove = [amount_left_to_remove, sp.remaining_quantity].min
          #calculates how much needs to be subracted from the next record, if any
          amount_left_to_remove = amount_left_to_remove - amount_to_remove
          #subtracts inventory from the current record 
          sp.remaining_quantity = sp.remaining_quantity - amount_to_remove
          #convert remaining grams back to remaining units
          sp.remaining_quantity = sp.remaining_quantity/sp.product.grams_per_unit 
          sp.save! #saves result to database
          break amount_left_to_remove == 0
      end 
  end

  #removes inventory when they are used up by a Production 
  def self.remove_sold_inventory(product_id, usage_amount)    
    
      return if usage_amount.nil? || usage_amount == 0

      inventories = Inventory.where("product_id = ? and remaining_quantity > 0", product_id).order("created_at asc")
      amount_left_to_remove = usage_amount

      inventories.each do |sp|
          #sets remaining amount equalt to remaining amount for the oldest record in the database
          amount_to_remove = [amount_left_to_remove, sp.remaining_quantity].min
          
          #calculates how much needs to be subracted from the next record, if any
          amount_left_to_remove = amount_left_to_remove - amount_to_remove
          
          #subtracts inventory from the current record 
          sp.remaining_quantity = sp.remaining_quantity - amount_to_remove

          #saves result to database          
          sp.save!      
            
          break if amount_left_to_remove == 0
      end 
  end

  def set_cost_per_unit    
    if
      production_id.blank? && !purchase_product_id.blank?
      self.cost_per_unit = purchase_product.purchase_price
    end

  end

  def self.search(search)
    if !search.blank?
        return Inventory.where("product_id = ? or product_name ILIKE ? or purchase_order_product_id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
    else
    Inventory.all
    end
  end


  def self.inventory_summary(search_product, pick_product, datefilter_start, datefilter_end, sortable, sort_direction)

      datefilter_start = Date.strptime( datefilter_start, '%m/%d/%Y')       
      datefilter_end = Date.strptime( datefilter_end, '%m/%d/%Y')     


#search box (search_product)

      where_search = " (product_name ILIKE '%#{search_product}%' OR unit ILIKE '%#{search_product}%' OR product_id = #{search_product.to_i} 
                      OR current_inventory = #{search_product.to_f})"
    
      if search_product.blank?
        where_search = ""
      end  

#product multi-select (pick_product)
        
      if pick_product.blank? || pick_product == [""] 
        where_picker = ""
      else
        where_picker = "product_id IN (#{pick_product.join(",")})"
      end

#filter by time period (date_filter_start & _end)    

      where_time_period = "WHERE inventories.created_at >= #{SqlHelper.escape_sql_param(datefilter_start.to_date)} AND inventories.created_at <= #{SqlHelper.escape_sql_param(datefilter_end.to_date)}"
      
      where_statement = WhereBuilder.build([where_search, where_picker])

#column sorting (sortable & sort_direction)

      if !["product_id", "product_name", "current_inventory", "weigthed_cost_per_unit", "unit"].include?(sortable)
        sortable = "product_name"
      end

      if  sort_direction == "desc"
        "desc"
      else
        sort_direction = "asc"
      end
        
      sql = """
                SELECT * FROM (
                  SELECT product_id, product_name, unit, 
                    (CASE
                      WHEN 
                      SUM(remaining_quantity) > 0
                      THEN
                      (SUM(cost_per_unit * remaining_quantity))/(SUM(remaining_quantity))
                      ELSE
                      0
                    END) AS weighted_cost_per_unit,  
                  SUM(remaining_quantity) AS current_inventory
                  FROM inventories
                  LEFT OUTER JOIN products ON product_id = products.id
                  #{where_time_period}
                  GROUP BY product_id, product_name, unit
                  ) report
                #{where_statement}            
                ORDER BY #{sortable} #{sort_direction}

            """
      result = ActiveRecord::Base.connection.execute(sql)  
        
        
  end
end
