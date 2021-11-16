class OrderProduct < ApplicationRecord
    belongs_to :order
    validates :quantity, :sale_price, presence: true, length: { minimum: 1, maximum: 25}
    has_many :inventories
    after_save :set_current_amount_left
    validate :has_enough_inventory
    

    def set_subtotal
      self.subtotal = quantity * sale_price
    end
    
    def has_enough_inventory

      # total_inv = Inventory.where("product_id = ? and current_amount_left > 0", self.product_id).sum(&:current_amount_left)
      
      total_inv = 0
      Inventory.where("product_id = ? and current_amount_left > 0", self.product_id).each do |inv|
        total_inv = total_inv + inv.current_amount_left 
      end

      if total_inv < self.quantity
        errors.add(:quantity, "Order cannot take place")
      end
    end

    def set_current_amount_left
      delta = self.quantity - (quantity_was || 0)

       Inventory.where("product_id = ? and current_amount_left > 0", self.product_id).each do |inv|        
        inv.current_amount_left = inv.current_amount_left.to_d - self.quantity         
        res = inv.save!       
      end 
    end
end

# Before the loop you need to keep track of how much inventory you have to remove. 
# Then you go through each record and try to remove it.
# Before you even save the record, you should check to make sure there is enough inventory for the order
# Do an .order after the where
# Is the problem the view is not showing it? Or the model is not getting it? Or the controller is doing something else with it?
# Try to track it through the process until you find the exact line of code that is not doing what you think it should do