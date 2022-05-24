class PurchaseProduct < ApplicationRecord
    belongs_to :purchase
    belongs_to :product
    has_one :inventory
    after_validation :set_purchase_subtotal
   

    def set_purchase_subtotal

        if purchase_price.blank? || purchase_quantity.blank?
            self.purchase_subtotal = nil
        else
            self.purchase_subtotal = purchase_quantity * purchase_price
        end
    end

    

end
