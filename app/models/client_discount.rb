class ClientDiscount < ApplicationRecord
belongs_to :client
has_many :order_product_discounts
before_create :set_remaining_amount
validates :client_id, :discount_per_unit, :discounted_units, presence: true

    def set_remaining_amount
        self.discounted_units_left = self.discounted_units
    end
    
end
