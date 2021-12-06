class OrderProduct < ApplicationRecord
    belongs_to :order
    has_many :supply_products
    validates :sale_price, :quantity, presence: true
    after_validation :set_subtotal
    before_save :adjust_inventory
    
    
        
    def set_subtotal
        self.subtotal = quantity * sale_price
    end
   

    def adjust_inventory

        change_in_quantity = self.quantity - (self.quantity_was || 0)

        supply_products = SupplyProduct.where("product_id = ? and remaining_quantity > 0", self.product_id).order("created_at asc")
        available_inventory = SupplyProduct.where("product_id = #{self.product_id}").sum(:remaining_quantity)

        amount_left_to_remove = change_in_quantity

        if change_in_quantity < available_inventory
              
            supply_products.each do |sp|
                
                #sets remaining amount equalt to remaining amount for the oldest record in the database
                amount_to_remove = [amount_left_to_remove, sp.remaining_quantity].min
                #calculates how much needs to be subracted from the next record, if any
                amount_left_to_remove = amount_left_to_remove - amount_to_remove
                #subtracts inventory from the current record
                sp.remaining_quantity = sp.remaining_quantity - amount_to_remove
                
                sp.save! #saves result to database
                
                break if amount_left_to_remove == 0             
            end 
        else alert ("Insuficient Inventory!")
        end

    end        
end
