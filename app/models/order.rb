class Order < ApplicationRecord
    has_many :order_products
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
    
    def self.search(search, client_select, start_date, end_date)
      
      where_statements = []

      if !search.blank?
        tmp = "(clients.name ILIKE '%#{search}%' 
               OR clients.id = #{search.to_i})"
        where_statements.push(tmp)
      end

      if !client_select.blank?
        ids = []
        client_select.each do |cs|
          ids.push(cs.to_i)
        end
        tmp = "clients.id in (#{SqlHelper.escape_sql_param(ids)})"
        where_statements.push(tmp)
      end 

      if !start_date.blank? && !end_date.blank?
        where_statements.push("(CAST(orders.created_at AS DATE) >= #{SqlHelper.escape_sql_param(start_date.to_date)} AND CAST(orders.created_at AS DATE) <= #{SqlHelper.escape_sql_param(end_date.to_date)})")
      end
      
      where_clause = where_statements.join(" AND ")
      return Order.joins(:client).where(where_clause)
    end

    def self.client_report(search_text, client_ids, sortable, sort_direction)       
      if !["client_id", "clients_name", "total_money_spent", "number_of_orders"].include?(sortable)
        sortable = "client_id"  
      end

      if sort_direction == "desc"
        "desc"       
      else
        sort_direction = "asc"
      end
      
      search_text_where = "clients_name ILIKE '%#{search_text}%' OR total_money_spent = #{search_text.to_d} OR client_id = #{search_text.to_i} OR number_of_orders = #{search_text.to_i}"

      if search_text.blank?
        search_text_where = ""
      end

      if client_ids.blank? || client_ids == [""]
        client_id_where = ""
      else
        client_id_where = "client_id IN (#{client_ids.join(", ")})"
      end

      where_clause = WhereBuilder.build([client_id_where, search_text_where])

      sql = """

          SELECT *
          FROM (
            SELECT DISTINCT(client_id), clients.name AS clients_name,
            SUM(grand_total) AS total_money_spent,
            COUNT(orders.id) AS number_of_orders 
            FROM orders           
            JOIN clients ON orders.client_id=clients.id
            GROUP BY client_id, clients.name     
          ) report
          #{where_clause} 
          ORDER BY #{sortable} #{sort_direction}

        """
      result = ActiveRecord::Base.connection.execute(sql)      
    end

    # sortable must be a column in this report
    def self.product_report(search_text, product_ids, start_date, end_date, sortable, sort_direction)
      if !["product_name", "price", "amount_sold", "amount_made", "avg(sale_price)"].include?(sortable)
        sortable = "product_name"  
      end      

      if sort_direction  == "desc"
        "desc"      
      else
        sort_direction = "asc"
      end

      search_text_where = " (product_name ILIKE '%#{search_text}%' 
                             OR price = #{search_text.to_d} 
                             OR amount_sold = #{search_text.to_d} 
                             OR amount_made = #{search_text.to_d} 
                             OR average_unit_price = #{search_text.to_d} 
                             OR product_id = #{search_text.to_i} )"     
      
      if search_text.blank?
        search_text_where = ""
      end

      if product_ids.blank? || product_ids == [""]
        product_id_where = ""
      else
        product_id_where = "(product_id IN (#{product_ids.join(", ")}) )"
      end
      
      date_filter_where = "WHERE order_products.created_at >= cast(now() as date) - interval '30' day"

      if start_date.blank? || end_date.blank?
        date_filter_where = "WHERE order_products.created_at >= cast(now() as date) - interval '30' day" 
      else
        date_filter_where = "WHERE CAST(order_products.created_at AS DATE) >= #{SqlHelper.escape_sql_param(start_date.to_date)} 
                             AND CAST(order_products.created_at AS DATE) <= #{SqlHelper.escape_sql_param(end_date.to_date)}"
      end  

      where_clause = WhereBuilder.build([product_id_where, search_text_where])

      sql = """
           SELECT * FROM (
             SELECT 
                DISTINCT(product_name), 
                products.price, 
                COUNT(quantity) AS amount_sold, 
                SUM(subtotal) AS amount_made, 
                ROUND(AVG(sale_price)::numeric, 2) AS average_unit_price,
                products.id AS product_id 
             FROM products
             JOIN order_products ON products.id=order_products.product_id
             #{date_filter_where}
             GROUP BY product_name, price, products.id
            ) report    
            #{where_clause}   
           ORDER BY #{sortable} #{sort_direction}                      
        """

      result = ActiveRecord::Base.connection.execute(sql)
    end
end