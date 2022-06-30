class PurchaseProduct < ApplicationRecord
    belongs_to :purchase
    belongs_to :product
    has_one :inventory
    after_validation :set_purchase_subtotal
   

    def p_o_name
        "P.O.#{id} | #{product.product_name} | #{created_at.to_date.strftime("%d %b %Y")}"
    end
    
    def set_purchase_subtotal

        if purchase_price.blank? || purchase_quantity.blank?
            self.purchase_subtotal = nil
        else
            self.purchase_subtotal = purchase_quantity * purchase_price
        end
    end

    

end
