class SupplyProduct < ApplicationRecord
    belongs_to :supply
    validates :purchase_price, :purchase_quantity, presence: true
    after_validation :set_purchase_subtotal
        
    def set_purchase_subtotal
        self.purchase_subtotal = purchase_quantity * purchase_price
    end

end