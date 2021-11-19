class OrderProduct < ApplicationRecord
  belongs_to :order
  validates :quantity, :sale_price, presence: true, length: { minimum: 1, maximum: 25}
  has_many :inventories
  before_save :set_current_amount_left
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
  
  def set_current_amount_left   
    
    # amount_left_to_remove should always be the amount of inventory that we still have to remove
    change_in_quantity = self.quantity - (self.quantity_was || 0)
    amount_left_to_remove = change_in_quantity

    # 1: Find out how much we need to remove from inventory by setting it equal to amount_bought.(What does it mean to set equal to amount_bought?)
    # 2: Get the oldest muffin inventory with amount left.(How to do this?)
    # 3: Find the smaller number between amount_left_to_remove and oldest_inventory.current_amount_left and store that as amount_to_remove.
    # How to get the oldest_inventory.current_amount_left?
    # 4: Subtract amount_to_remove from oldest_inv.current_amount_left and store it in current_amount_left.
    # 5: Save the oldest_inv.current_amount_left.
    # 6: Subtract amount_to_remove from amount_left_to_removed and store in amount_left_to_remove.
    # 7: Now do it again.
   
    Inventory.where("product_id = ? and current_amount_left > 0", self.product_id).order(:created_at, :id).each do |inv|              
      
      break if amount_left_to_remove == 0

      # inv.current_amount_left, amount_left_remove
      amount_to_remove = [inv.current_amount_left, amount_left_to_remove].min
      
      inv.current_amount_left = inv.current_amount_left - amount_to_remove
      res = inv.save      

      amount_left_to_remove = amount_left_to_remove - amount_to_remove
    end     
  end
end


  
 












