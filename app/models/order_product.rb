class OrderProduct < ApplicationRecord
    belongs_to :order
    validates :sale_price, :quantity, presence: true
    after_validation :set_subtotal
    after_save :on_after_save
    after_save :set_remaining_quantity
        
    def set_subtotal
        self.subtotal = quantity * sale_price
    end
   

    def set_remaining_quantity

        # altr = amount left to remove (overall)
        # rem_a = remaining amount (in current inventory record)
        # atr = amount to remove (from current inventory record)

        altr = quantity
        remaining_quantity = oldest record where remaining_quantity > 0 

        while altr > 0, adjust_inventory.each do |ai|
            rem_a = remaining_quantity
            atr = [altr, rem_a].min
            altr = altr - atr
            rem_a = rem_a - atr
            
            set.remaining_quantity = rem_a
        end

    end        

    def on_after_save
        delta = quantity - (quantity_was || 0)
    end

end

