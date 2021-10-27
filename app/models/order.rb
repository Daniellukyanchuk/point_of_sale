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

    def self.client_report(sortable, sort_direction)       
      if !["client_id", "clients_name", "total_money_spent", "number_of_orders"].include?(sortable)
        sortable = "client_id"  
      end

      if sort_direction == "desc"
        "desc"       
      else
        sort_direction = "asc"
      end

      sql = """
          SELECT DISTINCT(client_id), clients.name AS clients_name, SUM(grand_total) AS total_money_spent, COUNT(orders.id) AS number_of_orders FROM orders
          JOIN clients ON orders.client_id=clients.id
          GROUP BY client_id, clients.name
          ORDER BY #{sortable} #{sort_direction}
        """
      result = ActiveRecord::Base.connection.execute(sql)      
    end

    # sortable must be a column this report
    def self.product_report(search_product, sortable, sort_direction)
      if !["product_name", "price", "amount_sold", "amount_made", "avg(sale_price)"].include?(sortable)
        sortable = "product_name"  
      end      

      if sort_direction  == "desc"
        "desc"      
      else
        sort_direction = "asc"
      end

      where_clause = "WHERE product_name = '#{search_product}' "

      if search_product.blank?
        where_clause = ""
      end

      sql = """
           SELECT DISTINCT(product_name), products.price, COUNT(quantity) AS amount_sold, SUM(subtotal) AS amount_made, AVG(sale_price) FROM products
           JOIN order_products ON products.id=order_products.product_id

           #{where_clause}

           GROUP BY product_name, price
           ORDER BY #{sortable} #{sort_direction}
           
           
        """
      result = ActiveRecord::Base.connection.execute(sql)
    end

end


