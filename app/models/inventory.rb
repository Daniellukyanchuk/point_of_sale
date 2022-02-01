class Inventory < ApplicationRecord
  belongs_to :product
  before_save :set_costs
  belongs_to :purchase_product, optional: true
  belongs_to :production_recipe, optional: true 

  after_initialize :init #used to set default values
  # attr_accessor :unit, :name

  def init
    self.date ||= DateTime.now
    self.price_per_unit ||= 0
  end


  Purchase.left_outer_joins(:inventories).where(inventories: {inventory_id: nil})

  def self.search(search, product_select, start_date, end_date)
    # my_hash = {a: "yo", b: "man"}
    # my_hash.each do |key, value|
    #   stop
    # end
    where_statements = []

    if !search.blank?
      tmp = "(products.product_name ILIKE '%#{search}%' 
               OR product_id = #{search.to_i} OR amount = #{search.to_d} 
               OR price_per_unit = #{search.to_d} or costs = #{search.to_d} 
               OR current_amount_left = #{search.to_d})"
      
      where_statements.push(tmp)
    end

    if !product_select.blank?
      ids = []
      product_select.each do |ps|
        ids.push(ps.to_i)
      end
      tmp = "product_id in (#{SqlHelper.escape_sql_param(ids)})"
      where_statements.push(tmp)
    end

    if !start_date.blank? && !end_date.blank?
      where_statements.push("(CAST(inventories.created_at AS DATE) >= #{SqlHelper.escape_sql_param(start_date.to_date)} AND CAST(inventories.created_at AS DATE) <= #{SqlHelper.escape_sql_param(end_date.to_date)})")
    end
    where_clause = where_statements.join(" AND ")
    return Inventory.joins(:product).where(where_clause)
  end

  def self.current_inventory_for(product_id)
  	return Inventory.where("product_id = ? and current_amount_left > 0", product_id).sum(&:current_amount_left)
  end

  def self.remove_inventory(product_id, amount)
    amount_left_to_remove = amount
    Inventory.where("product_id = ? and current_amount_left > 0", product_id).order(:created_at, :id).each do |inv|  
      break if amount_left_to_remove == 0
      amount_to_remove = [inv.current_amount_left, amount_left_to_remove].min
      inv.current_amount_left = inv.current_amount_left - amount_to_remove
      res = inv.save      
      amount_left_to_remove = amount_left_to_remove - amount_to_remove
    end 
  end

  def self.add_inventory(product_id, amount, recipe_price)
    
    inventory = Inventory.create(product_id: product_id, amount: amount, current_amount_left: amount, price_per_unit: recipe_price)
  end

  
  def set_costs  	
  	if self.current_amount_left == nil
  		self.current_amount_left = 0
  	end

    self.costs = self.amount * self.price_per_unit
    # Delta of purchased shows the change and what was saved. If it were 100 saved and then they decided to change it to 120, then the delta is 20.
    delta_of_purchased = self.amount - (self.amount_was || 0)
    self.current_amount_left = self.current_amount_left + delta_of_purchased   
  end
end