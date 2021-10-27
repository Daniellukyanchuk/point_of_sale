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

    def self.product_report(sortable)

      if !["product_id", "product_name", "units_sold", "total_revenue"].include[:direction]
      else
      sortable = "product_id"

      
        direction == desc
      else
        direction = asc


      sql = """
      SELECT product_id,product_name,unit, SUM(quantity) AS units_sold, SUM(subtotal) AS total_revenue
      FROM order_products
      INNER JOIN products
      ON order_products.product_id = products.id
      GROUP BY product_id,product_name,unit
      ORDER BY #{sortable} #{direction}}
      """
      result = ActiveRecord::Base.connection.execute(sql)
    
    end

      
    def self.client_report(sortable)

       
      sql = """
      SELECT client_id,name, COUNT(grand_total) AS orders_placed, 
      SUM(grand_total) AS total_spent, AVG(grand_total) AS avg_spent
      FROM orders
      INNER JOIN clients
      ON orders.client_id = clients.id
      GROUP BY client_id,name
      ORDER BY #{sortable} #{direction}
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
