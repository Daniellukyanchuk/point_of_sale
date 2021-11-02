class Order < ApplicationRecord
    has_many :order_products
    has_many :client_reports
    has_many :product_reports
    belongs_to :client  
    accepts_nested_attributes_for :order_products, allow_destroy: true
    before_save :set_grand_total
    
    def set_grand_total
      self.grand_total = 0
      order_products.each do |op|
        op.set_subtotal
        self.grand_total = self.grand_total + op.subtotal
      end    
    end

    def self.product_report(search_product, pick_product, sortable, sort_direction)
      if !["product_id", "product_name", "units_sold", "total_revenue"].include?(sortable)
        sortable = "total_revenue"
      end
      
      if  sort_direction == "desc"
        "desc"
      else
        sort_direction = "asc"
      end

      where_search = "WHERE product_name ILIKE '%#{search_product}%' OR unit ILIKE '%#{search_product}%' OR product_id = #{search_product.to_i} 
                      OR units_sold = #{search_product.to_f} OR total_revenue = #{search_product.to_f}"
    
      if search_product.blank?
        where_search = ""
      end  

     
      if pick_product.blank? || pick_product == [""] 
        where_picker = ""
      else
        where_picker = "WHERE product_id IN (#{pick_product.join(",")})"
      end
           
      sql = """
            SELECT * FROM (
            SELECT product_id,product_name,unit, SUM(quantity)::numeric(10,2) AS units_sold, SUM(subtotal)::numeric(12,2) AS total_revenue
            FROM order_products
            INNER JOIN products
            ON order_products.product_id = products.id
            GROUP BY product_id,product_name,unit
            ) report
            #{where_search} #{where_picker}           
            ORDER BY #{sortable} #{sort_direction}
      """
      result = ActiveRecord::Base.connection.execute(sql)      
          
    end

      
    def self.client_report(search_client, pick_client, sortable, sort_direction)

      if !["client_id", "name", "orders_placed", "total_spent"].include?(sortable)
        sortable = "total_spent"
      end

      if  sort_direction == "desc"
        "desc"
      else
        sort_direction = "asc"
      end

      where_search = " name ILIKE '%#{search_client}%' OR client_id = #{search_client.to_i} OR orders_placed = #{search_client.to_d} OR total_spent = #{search_client.to_d}"
      if search_client.blank?
        where_search = ""
      end  

      if pick_client.blank? || pick_client == [""] 
        where_picker = ""

      else
        where_picker = "client_id IN (#{pick_client.join(",")})"
      end

      if !where_search.blank? || !where_picker.blank?
        where_statement = "WHERE"
      else
        where_statement = ""
      end

      if !where_search.blank? && !where_picker.blank?
        and_statement = "AND"
      else
        and_statement = ""
      end
  

        sql = """
              SELECT * FROM (
              SELECT client_id,name, COUNT(grand_total) AS orders_placed, 
              SUM(grand_total)::numeric(12,2) AS total_spent, AVG(grand_total)::numeric(12,2) AS avg_spent
              FROM orders
              INNER JOIN clients
              ON orders.client_id = clients.id
              GROUP BY client_id,name
              ) report
              #{where_statement} #{where_search} #{and_statement} #{where_picker}             
              ORDER BY #{sortable} #{sort_direction}
        """
        result = ActiveRecord::Base.connection.execute(sql)

    end

    def self.search(search)

      if !search.blank?
        return Order.joins(:client).where("clients.name ilike ? or clients.id = ? or client_id = ?", "%#{search.strip}%", search.to_i, search.to_i)
          else
        return Order.all
      end
     end  

end
