class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, :sale_price, presence: true, length: { minimum: 1, maximum: 25}
  has_many :inventories
  before_save :set_current_amount_left
  validate :has_enough_inventory

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
    
    if total_inv.to_d < self.quantity.to_d
      errors.add(:quantity, "Not enough inventory for this product")
    end
  end
  
  def set_current_amount_left   
    
    # amount_left_to_remove should always be the amount of inventory that we still have to remove
    # make a variable change_in_quantity and set it equal to self.quatity.
    change_in_quantity = self.quantity - (self.quantity_was || 0)
    # make a variable amount_left_to_remove and set it equal to change_in_quantity.
    
    Inventory.remove_inventory(self.product_id, change_in_quantity)    
  end
end


  
 












