class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, :sale_price, presence: true, length: {minimum: 1, maximum: 25}
  has_many :inventories
  has_many :order_product_discounts
  before_save :set_current_amount_left, :expiration_amount_valid?
  validate :has_enough_inventory

  def set_subtotal
    self.subtotal = quantity * sale_price
  end
  
  # What am I doing here? 
  def expiration_amount_valid?
    discounts = Discount.where("client_id = ? and (starting_date is null or starting_date < ?) 
    and (ending_date is null or ending_date > ?) and (current_expiration_amount > 0 
    or expiration_amount is null)", order.client_id, created_at || DateTime.now, created_at || DateTime.now).order("discount_per_kilo desc")

    # Go through order and set order_product.subtotal with a discount.
    
    order.order_products.each do |op|
      stop

      amount_left_to_apply_from_discount = op.quantity
      op.client_discount = 0 
      discounts.each do |d|
        
        if d.current_expiration_amount >= op.quantity

        else
          op.client_discount += (d.current_expiration_amount / op.quantity) * d.discount_per_unit
          amount_left_to_apply_from_discount -= d.current_expiration_amount
          d.current_expiration_amount = 0



        end
        d.current_expiration_amount
        op.client_discount = d.discount_per_unit

      end
      # client_discount = op.quantity * .first
    end
    # Set grand_total with a discount. 
    # client_discount * quantity, the sum of that subtracted from subtotal.
  end

  def has_enough_inventory
    # Here I am checking if there is enough inventory for the product.
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
    # make a variable change_in_quantity and set it equal to self.quantity.
    change_in_quantity = self.quantity - (self.quantity_was || 0)
    # make a variable amount_left_to_remove and set it equal to change_in_quantity.
    Inventory.remove_inventory(self.product_id, change_in_quantity)    
  end
end


  
 












