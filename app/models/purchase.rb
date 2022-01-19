class Purchase < ApplicationRecord
    has_many :purchase_products, dependent: :destroy
    has_many :product_reports
    belongs_to :supplier
    accepts_nested_attributes_for :purchase_products, allow_destroy: true
    before_save :set_estimated_total
    before_save :set_purchase_total
    before_validation :parse_dates
    

    

    def parse_dates
        if !date_ordered.blank?
        self.date_ordered =  Date.strptime(self.date_ordered.to_s, "%Y-%d-%m")
        end
        if !date_expected.blank?
        self.date_expected =  Date.strptime(self.date_expected.to_s, "%Y-%d-%m")
        end
        if !date_received.blank?
        self.date_received =  Date.strptime(self.date_received.to_s, "%Y-%d-%m")
        end
    end

    def set_estimated_total

        self.estimated_total = 0
        #loop to add up subtotals into estimated total
        purchase_products.each do |sp|
          sp.set_estimated_subtotal
          self.estimated_total = self.estimated_total + sp.estimated_subtotal
        end  
    end

    def set_purchase_total

        if purchase_products.any? {|sp| sp.purchase_quantity.blank? || sp.purchase_price.blank?}
            self.purchase_total = nil        
        else
            self.purchase_total = 0
              #loop to add up subtotals into purchase total
              purchase_products.each do |sp|
              sp.set_purchase_subtotal
              self.purchase_total = self.purchase_total + sp.purchase_subtotal
              end           
        end 
    end


    ########### PURCHASE REPORT #############

    def self.purchase_report(search_product, pick_product, datefilter_start, datefilter_end, sortable, sort_direction)

     
      datefilter_start = Date.strptime( datefilter_start, '%m/%d/%Y')       
      datefilter_end = Date.strptime( datefilter_end, '%m/%d/%Y')     


    #search box (search_product)

      where_search = "(product_name ILIKE '%#{search_product}%' OR unit ILIKE '%#{search_product}%' OR product_id = #{search_product.to_i} 
                      OR units_purchased = #{search_product.to_f} OR current_inventory = #{search_product.to_f} 
                      OR current_inventory_value = #{search_product.to_f} OR cost_per_unit = #{search_product.to_f})"
    
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

      where_time_period = "WHERE purchase_products.created_at >= #{SqlHelper.escape_sql_param(datefilter_start.to_date)} AND purchase_products.created_at <= #{SqlHelper.escape_sql_param(datefilter_end.to_date)}"
      
      where_statement = WhereBuilder.build([where_search, where_picker])

#column sorting (sortable & sort_direction)

if !["product_id", "product_name", "unit", "units_purchased", "current_inventory", 
    "current_inventory_value", "cost_per_unit"].include?(sortable)
  sortable = "current_inventory_value"
end

if  sort_direction == "desc"
  "desc"
else
  sort_direction = "asc"
end
        
      sql = """
            SELECT * FROM (
                SELECT purchase_products.product_id, product_name, unit, 
                SUM(purchase_quantity)::numeric(10,2) AS units_purchased, 
                SUM(remaining_quantity)::numeric(10,2) AS current_inventory,
                SUM((remaining_quantity*purchase_price)::numeric(12,2)) AS current_inventory_value,
                (((SUM(remaining_quantity*purchase_price))/(SUM(remaining_quantity)))::numeric(10,2)) AS cost_per_unit
                FROM purchase_products
                LEFT OUTER JOIN products ON purchase_products.product_id = products.id
                LEFT OUTER JOIN inventories ON purchase_products.product_id = inventories.product_id
                #{where_time_period} 
                GROUP BY purchase_products.product_id, product_name, unit
            ) report
            #{where_statement}            
            ORDER BY #{sortable} #{sort_direction}
      """

      result = ActiveRecord::Base.connection.execute(sql)      

    end

    ########## Purchase Records (itemised) ###############

    def self.purchase_record(search_product, pick_product, datefilter_start, datefilter_end, sortable, sort_direction)

      
      datefilter_start = Date.strptime( datefilter_start, '%m/%d/%Y')       
      datefilter_end = Date.strptime( datefilter_end, '%m/%d/%Y') 

#search box (search_product)

      where_search = " (product_name ILIKE '%#{search_product}%' OR unit ILIKE '%#{search_product}%' OR product_id = #{search_product.to_i} 
                      OR quantity = #{search_product.to_f} OR sale_price = #{search_product.to_f})"
    
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

      where_time_period = "WHERE purchase_products.created_at >= #{SqlHelper.escape_sql_param(datefilter_start.to_date)} AND purchase_products.created_at <= #{SqlHelper.escape_sql_param(datefilter_end.to_date)}"
      
      where_statement = WhereBuilder.build([where_search, where_picker])

#column sorting (sortable & sort_direction)

      if !["supplier_name", "supplier_id", "product_name", "estimated_quantity", "actual_quantity", "estimated_cost", 
        "actual_cost", "estimated_subtotal", "actual_subtotal", "date_ordered", "date_expected", "date_received"].include?(sortable)
        sortable = "date_ordered"
      end

      if  sort_direction == "desc"
        "desc"
      else
        sort_direction = "asc"
      end
        
      sql = """
            SELECT * FROM (
              SELECT supplier_id, purchase_id AS purchase_order_id, supplier_name, product_name, 
              estimated_quantity, purchase_quantity AS actual_quantity, estimated_cost, purchase_price AS actual_cost,
              estimated_subtotal, purchase_subtotal AS actual_subtotal,
              date_ordered, date_expected, date_received
              FROM purchases
              LEFT OUTER JOIN purchase_products ON purchase_id = purchases.id
              LEFT OUTER JOIN products ON product_id = products.id
              LEFT OUTER JOIN suppliers ON supplier_id = suppliers.id   
              #{where_time_period} 
              ) report
            #{where_statement}            
            ORDER BY #{sortable} #{sort_direction}
      """

      result = ActiveRecord::Base.connection.execute(sql)        
    end
end
