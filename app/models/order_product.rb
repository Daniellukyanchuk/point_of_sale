class OrderProduct < ApplicationRecord
    belongs_to :order
    validates :sale_price, :quantity, presence: true
    after_validation :set_subtotal

    after_save :on_after_save
        
    def set_subtotal
        self.subtotal = quantity * sale_price
    end

    def on_after_save
        delta = quantity - (quantity_was || 0)
    end

end

