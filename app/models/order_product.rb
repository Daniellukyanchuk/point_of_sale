class OrderProduct < ApplicationRecord
    belongs_to :order
    validates :quantity, :sale_price, presence: true, length: { minimum: 1, maximum: 25}
    has_many :inventories
    after_save :set_current_amount_left
    before_save :set_if_inventory_enough

   

    def set_subtotal
      self.subtotal = quantity * sale_price
    end

    def set_if_inventory_enough
      if Inventory.current_amount_left < self.quantity
        return "There isn't enough inventory"
      end
    end

    def set_current_amount_left      
    # The code below returns all the inventories for that product that have any inventory left
      Inventory.where("product_id = ? and current_amount_left > 0", self.product_id).each do |inv|        
        inv.current_amount_left = inv.current_amount_left.to_d - self.quantity  
        inv.save      
      end 
    end
end

# Before the loop you need to keep track of how much inventory you have to remove. 
# Then you go through each record and try to remove it.
# Before you even save the record, you should check to make sure there is enough inventory for the order
# You need to call inv.save to actually update the inventory record
# You might want to go one step further and do an .order after the where


# So you are saying the Inventories View is not showing the information from the Inventories Table?
# Try to find out what level your problem is on:
# Is the problem the view is not showing it? Or the model is not getting it? Or the controller is doing something else with it?
# Try to track it through the process until you find the exact line of code that is not doing what you think it should do