class OrderProduct < ApplicationRecord
    belongs_to :order
    validates :sale_price, :quantity, presence: true
    after_commit :set_subtotal
        
    def set_subtotal
        self.subtotal = quantity * sale_price
    end

end

