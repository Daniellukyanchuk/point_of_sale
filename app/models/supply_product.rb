class SupplyProduct < ApplicationRecord
    belongs_to :supply
    validates :estimated_cost, :estimated_quantity, presence: true
    before_validation :set_estimated_subtotal
    after_validation :set_purchase_subtotal
    before_create :set_remaining_quantity


    
    def set_estimated_subtotal
        self.estimated_subtotal = self.estimated_quantity * self.estimated_cost
    end

    def set_purchase_subtotal

        if purchase_price.blank? || purchase_quantity.blank?
            self.purchase_subtotal = nil
        else
            self.purchase_subtotal = purchase_quantity * purchase_price
        end
    end

    def set_remaining_quantity

        if purchase_quantity.blank?
            self.remaining_quantity = nil
        else
            self.remaining_quantity = purchase_quantity
        end
    end

end

