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
        errors.add(:quantity, "Not enough inventory for this product")
      end
    end

    def set_current_amount_left
      
      if self.quantity == nil
        self.quantity = 0
      end
      Inventory.where("product_id = ? and current_amount_left > 0", self.product_id).each do |inv|        
        delta_of_purchased = self.quantity - (quantity_was || 0) 
        inv.current_amount_left = inv.current_amount_left + delta_of_purchased      
        res = inv.save!       
      end 
    end
end
# Do an .order after the where