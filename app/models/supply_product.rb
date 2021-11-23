class SupplyProduct < ApplicationRecord
    belongs_to :supply
    validates :purchase_price, :purchase_quantity, presence: true
    after_validation :set_purchase_subtotal
    before_create :set_remaining_quantity

        
    def set_purchase_subtotal
        self.purchase_subtotal = purchase_quantity * purchase_price
    end

    def set_remaining_quantity
        self.remaining_quantity = purchase_quantity
    end

end

