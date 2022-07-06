class Order < ApplicationRecord
    has_many :order_products, dependent: :destroy
    has_many :client_reports
    has_many :product_reports
    belongs_to :client  
    accepts_nested_attributes_for :client, allow_destroy: true
    accepts_nested_attributes_for :order_products, allow_destroy: true
    before_save :set_discounted_sales_prices
    before_save :set_grand_total
    after_save :remove_from_inventory

    attr_accessor :order_discount

    #remove sold items from inventory 
    def remove_from_inventory   
      
            self.order_products.each do |ri|
                # quantity to remove
                amount_to_remove = ri.quantity
            Inventory.remove_sold_inventory(ri.product_id, amount_to_remove)
            
        end
    end    
    
    def set_grand_total

      self.grand_total = 0
      order_products.each do |op|
        op.set_subtotal
        self.grand_total += op.subtotal
      end 
      self.grand_total 
    end

    def set_discounted_sales_prices
      
      if !self.order_discount.blank?
        order_products.each do |sp|
          percent_of_whole = sp.subtotal / self.grand_total
          percent_of_whole_per_item = percent_of_whole / sp.quantity
          som_disount_per_unit = percent_of_whole_per_item * self.order_discount.to_i
          sp.sale_price = sp.sale_price - som_disount_per_unit
        end
      end
    end

    

    

# SALES REPORT

    def self.product_report(search_product, pick_product, datefilter_start, datefilter_end, sortable, sort_direction)
      
      datefilter_start = Date.strptime( datefilter_start, '%m/%d/%Y')       
      datefilter_end = Date.strptime( datefilter_end, '%m/%d/%Y')     

#search box (search_product)

      where_search = " (product_name ILIKE '%#{search_product}%' OR unit ILIKE '%#{search_product}%' OR product_id = #{search_product.to_i} 
                      OR units_sold = #{search_product.to_f} OR total_revenue = #{search_product.to_f})"
    
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

      where_time_period = "WHERE order_products.created_at >= #{SqlHelper.escape_sql_param(datefilter_start.to_date)} AND order_products.created_at <= #{SqlHelper.escape_sql_param(datefilter_end.to_date)}"
      
      where_statement = WhereBuilder.build([where_search, where_picker])

#column sorting (sortable & sort_direction)

      if !["product_id", "product_name", "units_sold", "total_revenue", "sales_price_per_unit"].include?(sortable)
        sortable = "total_revenue"
      end

      if  sort_direction == "desc"
        "desc"
      else
        sort_direction = "asc"
      end
        
      sql = """
            SELECT * FROM (
                SELECT product_id, product_name, unit, 
                SUM(quantity)::numeric(10,2) AS units_sold,
                SUM(subtotal)::numeric(12,2) AS total_revenue,
                ((SUM(quantity*sale_price))/(SUM(quantity)))::numeric(10,2) AS sales_price_per_unit
                FROM order_products
                LEFT OUTER JOIN products ON order_products.product_id = products.id            
                #{where_time_period} 
                GROUP BY order_products.product_id, product_name, unit  
            ) report
            #{where_statement}            
            ORDER BY #{sortable} #{sort_direction}
      """

      result = ActiveRecord::Base.connection.execute(sql)      
        
    end

# SALES RECORDS
    def self.sales_record(search_product, pick_product, datefilter_start, datefilter_end, sortable, sort_direction)

      
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

      where_time_period = "WHERE order_products.created_at >= #{SqlHelper.escape_sql_param(datefilter_start.to_date)} AND order_products.created_at <= #{SqlHelper.escape_sql_param(datefilter_end.to_date)}"
      
      where_statement = WhereBuilder.build([where_search, where_picker])

#column sorting (sortable & sort_direction)

      if !["product_id", "product_name", "quantity", "sale_price", "subtotal", "client", "client_id", "order_date"].include?(sortable)
        sortable = "order_date"
      end

      if  sort_direction == "desc"
        "desc"
      else
        sort_direction = "asc"
      end
        
      sql = """
            SELECT * FROM (
              SELECT  product_name, order_id, unit, quantity, sale_price, subtotal, client_id, name AS client_name, 
              CAST(order_products.created_at AS DATE) AS order_date
              FROM order_products
              LEFT OUTER JOIN products ON product_id = products.id
              LEFT OUTER JOIN orders ON order_id = orders.id
              LEFT OUTER JOIN clients ON client_id = clients.id     
                #{where_time_period} 
                ) report
            #{where_statement}            
            ORDER BY #{sortable} #{sort_direction}
      """

      result = ActiveRecord::Base.connection.execute(sql)      
        
    end

 # CLIENT REPORT     
    def self.client_report(search_client, pick_client, datefilter_start, datefilter_end, sortable, sort_direction)

      datefilter_start = Date.strptime( datefilter_start, '%m/%d/%Y')       
      datefilter_end = Date.strptime( datefilter_end, '%m/%d/%Y')

#column sorting      

      if !["client_id", "name", "orders_placed", "total_spent"].include?(sortable)
        sortable = "total_spent"
      end

      if  sort_direction == "desc"
        "desc"
      else
        sort_direction = "asc"
      end

#search box

      where_search = " (name ILIKE '%#{search_client}%' OR client_id = #{search_client.to_i} OR orders_placed = #{search_client.to_d} OR total_spent = #{search_client.to_d})"
      if search_client.blank?
        where_search = ""
      end  

#client multi-select

      if pick_client.blank? || pick_client == [""] 
        where_picker = ""

      else
        where_picker = " client_id IN (#{pick_client.join(",")})"
      end

#filter by time period   

      where_time_period = "WHERE orders.created_at >= #{SqlHelper.escape_sql_param(datefilter_start.to_date)} AND orders.created_at <= #{SqlHelper.escape_sql_param(datefilter_end.to_date)}"

      where_statement = WhereBuilder.build([where_search, where_picker])
    
        sql = """
              SELECT * FROM (
                  SELECT client_id, name, 
                  COUNT(grand_total) AS orders_placed, 
                  SUM(grand_total)::numeric(12,2) AS total_spent, 
                  AVG(grand_total)::numeric(12,2) AS avg_spent
                  FROM orders
                  INNER JOIN clients ON orders.client_id = clients.id
                  #{where_time_period}
                  GROUP BY client_id,name                 
              ) report
              #{where_statement}              
              ORDER BY #{sortable} #{sort_direction}
        """
        result = ActiveRecord::Base.connection.execute(sql)

    end

    def self.search(search)

      if !search.blank?
        return Order.includes(:client).where("clients.name ilike ? or clients.id = ? or client_id = ?", "%#{search.strip}%", search.to_i, search.to_i)
          else
        return Order.all
      end
     end  

end
