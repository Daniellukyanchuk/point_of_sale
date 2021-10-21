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

      return Order.left_joins(:clients).where("client_name like ? or id = ? or client_id = ?", "%#{search.strip}%", search, search)
    
      else
        Order.all
    end
  end
    
        

end
