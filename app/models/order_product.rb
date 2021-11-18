class OrderProduct < ApplicationRecord
  belongs_to :order
  validates :quantity, :sale_price, presence: true, length: { minimum: 1, maximum: 25}
  has_many :inventories
  after_save :set_current_amount_left
  validate :has_enough_inventory
    
  # num = 45
  # num2 = 84
  # [num, num2].min
  # (would return 45)
  def set_subtotal
    self.subtotal = quantity * sale_price
  end
  # Here I am checking if there is enough inventory for the product.
  def has_enough_inventory
    # total_inv = 0
    # Inventory.where("product_id = ? and current_amount_left > 0", self.product_id).each do |inv|
    #   total_inv = total_inv + inv.current_amount_left 
    # end
    total_inv = Inventory.where("product_id = ? and current_amount_left > 0", self.product_id).sum(&:current_amount_left)
    
    if total_inv < self.quantity
      errors.add(:quantity, "Not enough inventory for this product")
    end
  end
  # Should subtract quantity from inventories.current_amount_left.
  # Should subtract from the oldest inventory if there is enough, if not, subtract what there is and subtract the rest
  # from the next to the oldest inventory for the same product.   
  def set_current_amount_left      
    Inventory.where("product_id = ? and current_amount_left > 0", self.product_id).each do |inv|        
      inv.current_amount_left = inv.current_amount_left.to_d - self.quantity  
      inv.save            
    end 
  end
end
  # Do an .order after the where
  # Variable Name Description
  # Situation 1 Person buys 30 muffins  amount_bought 30
  # What should be the end result?  25 muffins should be taken from the oldest muffin inventory row, 
  # which is Inventory_id 1 and the next muffin row (2) should have 5 less     
  # Step 1: Find out how much we need to remove_from inventory by setting it equal to amount_bought amount_left_to_remove 30
  # Step 2: Get the oldest muffin inventory with amount left  oldest_inv  First inventory row
  # Step 3: Find the smaller number between amount_left_to_remove and 
  # oldest_inventory.current_amount_left and store that as amount_to_remove amount_to_remove   25
  # Step 4: Subtract amount_to_remove from oldest_inv.current_amount_left and store it in 
  # current_amount_left oldest_inv.current_amount_left   0
  # Step 5: Save the oldest_inv Now the table shows 0 for inv 1 current_amount_left 0
  # Step 6: Subtract amount_to_remove from amount_left_to_remobe and store in amount_left_to_remove amount_left_to_remove 5
  # Now do it again   












