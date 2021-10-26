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

    def self.product_report
      sql = """
      SELECT product_id, COUNT(subtotal), SUM(subtotal)
      FROM order_products
      GROUP BY product_id
      ORDER BY SUM(subtotal) DESC
      """

    end
  
    def self.client_report
      sql = """
      SELECT client_id, COUNT(grand_total), SUM(grand_total)
      FROM orders
      GROUP BY client_id
      ORDER BY COUNT(grand_total) DESC
      """
    end

    def self.search(search)

      if !search.blank?

        return Order.joins(:client).where("clients.name ilike ? or clients.id = ? or client_id = ?", "%#{search.strip}%", search.to_i, search.to_i)
    
      else
        return Order.all
      end
   

    end    
end
