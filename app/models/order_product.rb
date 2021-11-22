class OrderProduct < ApplicationRecord
    belongs_to :order
    has_many :supply_products
    validates :sale_price, :quantity, presence: true
    after_validation :set_subtotal
    before_save :adjust_inventory
    after_save :on_after_save
    
    
        
    def set_subtotal
        self.subtotal = quantity * sale_price
    end
   

    def adjust_inventory

        supply_products = SupplyProduct.where("product_id = ? and remaining_quantity > 0", self.product_id).order("created_at asc")
              
        amount_left_to_remove = self.quantity
               
        supply_products.each do |sp|
            remaining_amount = sp.remaining_quantity
            amount_to_remove = [amount_left_to_remove, remaining_amount].min
            amount_left_to_remove = amount_left_to_remove - amount_to_remove
            remaining_amount = remaining_amount - amount_to_remove 
            sp.remaining_quantity = remaining_amount
            sp.save
            break if amount_left_to_remove == 0
        end

    end        

    def on_after_save
        delta = quantity - (quantity_was || 0)
    end

end

