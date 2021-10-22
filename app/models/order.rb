class Order < ApplicationRecord
    has_many :order_products, :dependent => :destroy
    belongs_to :client    
    accepts_nested_attributes_for :order_products, :allow_destroy => true
    before_save :set_grand_total
    
    def set_grand_total

        self.grand_total = 0
        order_products.each do |op|
            op.set_subtotal
        end
    
        self.grand_total = self.grand_total + op.set_subtotal

    end

    def self.search(search)
        if !search.blank?
            return Order.joins(:client).where("clients.name ilike ? or clients.id like ? or client_id = ?", "%#{search.strip}%", search.to_i, search.to_i)
        else
        Order.all
      end
    end

end







