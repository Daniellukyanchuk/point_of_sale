class ClientDiscount < ApplicationRecord
before_create :set_remaining_amount
validates :discount_name, :client_id, :discount_per_unit, :discounted_units, :start_date, :end_date, presence: true

    def set_remaining_amount
        self.discounted_units_left = self.discounted_units
    end
    
end
