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

    def self.search(search)
      if !search.blank?
        return Order.joins(:client).where("clients.name ilike ? or clients.id = ? or client_id = ?", "%#{search.strip}%", search.to_i, search.to_i)    
      else
        return Order.joins(:client).all
      end
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

      # where_clause = ""

      # if client_id_where.blank? && search_text_where.blank?
      #   where_clause = ""  
      # else 
      #   where_clause = "WHERE"
      # end 
      
      # if client_id_where.blank? || search_text_where.blank?
      #   joiner = ""
      # else
      #   joiner = "OR"
      # end

      # where_clause += " #{client_id_where} #{joiner} #{search_text_where}"







      # where_clause += " #{client_id_where} or #{search_text_where}"  

      sql = """

          SELECT *
          FROM (
            SELECT DISTINCT(client_id), clients.name AS clients_name, SUM(grand_total) AS total_money_spent, COUNT(orders.id) AS number_of_orders 
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
    def self.product_report(search_product, sortable, sort_direction)
      if !["product_name", "price", "amount_sold", "amount_made", "avg(sale_price)"].include?(sortable)
        sortable = "product_name"  
      end      

      if sort_direction  == "desc"
        "desc"      
      else
        sort_direction = "asc"
      end

      where_clause = "WHERE product_name ILIKE '%#{search_product}%' OR price = #{search_product.to_d} OR amount_sold = #{search_product.to_d} OR amount_made = #{search_product.to_d} OR average_unit_price = #{search_product.to_d}"     
      
      if search_product.blank?
        where_clause = ""
      end

      sql = """
           SELECT * FROM (
             SELECT DISTINCT(product_name), products.price, COUNT(quantity) AS amount_sold, SUM(subtotal) AS amount_made, ROUND(AVG(sale_price)::numeric, 2) AS average_unit_price FROM products
             JOIN order_products ON products.id=order_products.product_id
             GROUP BY product_name, price
            ) report
           #{where_clause}            
           ORDER BY #{sortable} #{sort_direction}
                      
        """
      result = ActiveRecord::Base.connection.execute(sql)
    end
end