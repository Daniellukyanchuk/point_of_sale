class OrderProduct < ApplicationRecord
    belongs_to :order
    validates :quantity, :sale_price, presence: true, length: { minimum: 1, maximum: 25}
    before_save :set_current_amount_left

    def set_subtotal
      self.subtotal = quantity * sale_price
    end

     def set_current_amount_left
      Inventory.where("product_id = ?", "#{product_id.to_i}").each do |inv|        
          inv.current_amount_left = (inv.current_amount_left) - (self.quantity)
          # Make it subtract from one product, that has inventory left. If it is coffee, let it subtract from coffee, not from all.
        
      end
    end
end