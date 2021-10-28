class OrderProduct < ApplicationRecord
    belongs_to :order
    validates :quantity, :sale_price, presence: true, length: { minimum: 1, maximum: 25}
    
    def set_subtotal
      self.subtotal = quantity * sale_price
    end
end