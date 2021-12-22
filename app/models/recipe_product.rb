class RecipeProduct < ApplicationRecord
  belongs_to :recipe
  belongs_to :product
  has_many :inventories
  validate :has_enough_inventory

  def set_product_subtotal
    self.product_subtotal = product_amount * product_price
  end

  def has_enough_inventory
    # total_inv = 0
    # Inventory.where("product_id = ? and current_amount_left > 0", self.product_id).each do |inv|
    #   total_inv = total_inv + inv.current_amount_left 
    # end
    total_inv = Inventory.where("product_id = ? and current_amount_left > 0", self.product_id).sum(&:current_amount_left)
    
    if total_inv < self.product_amount
      errors.add(:product_amount, "Not enough inventory for this product")
    end
  end

  def set_current_amount_left   
    
    # amount_left_to_remove should always be the amount of inventory that we still have to remove
    # make a variable change_in_quantity and set it equal to self.quatity.
    change_in_product_amount = self.product_amount - (self.product_amount_was || 0)
    # make a variable amount_left_to_remove and set it equal to change_in_quantity.
    amount_left_to_remove = change_in_product_amount
    # make a loop of Inventory.where with product_id and current_amount_left. Make so, that it would search for current_amount_left > 0. order by created_at and id.

    Inventory.where("product_id = ? and current_amount_left > 0", self.product_id).order(:created_at, :id).each do |inv|              
    # Do a break if == 0.
      break if amount_left_to_remove == 0

      # inv.current_amount_left, amount_left_remove
      # Get the minimum of current_amount_left and amount_left_to_remove and set it equal to amount_to_remove.
      amount_to_remove = [inv.current_amount_left, amount_left_to_remove].min
      # Subtract amount_to_remove from current_amount_left and set it equal to current_amount_left. 
      inv.current_amount_left = inv.current_amount_left - amount_to_remove
      # Do save and set it equal to whatever.
      res = inv.save      
      # Subtract amount_to_remove from amount_left_to_remove and set it equal to amount_left_to_remove.
      amount_left_to_remove = amount_left_to_remove - amount_to_remove
    end     
  end

end