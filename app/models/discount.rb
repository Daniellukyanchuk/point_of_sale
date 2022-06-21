class Discount < ApplicationRecord
	belongs_to :client
	has_many :order_product_discounts
	before_save :set_current_expiration_amount

    # Set current_expiration_amount. 
    def set_current_expiration_amount
      if self.id == nil
      	self.current_expiration_amount = 0
      end

      if self.expiration_amount == nil
      	self.expiration_amount = 0
      end

      delta_of_exp_amount = self.expiration_amount - (self.expiration_amount_was || 0)
      self.current_expiration_amount = self.current_expiration_amount + delta_of_exp_amount
    end
end
