class SupplyProduct < ApplicationRecord
    belongs_to :supply
    belongs_to :inventory
    validates :estimated_cost, :estimated_quantity, presence: true
    before_validation :set_estimated_subtotal
    after_validation :set_purchase_subtotal
   


    
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

    

end

