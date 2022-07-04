class OrderProductDiscount < ApplicationRecord
	belongs_to :discount
	belongs_to :order_product 
	after_destroy :put_back_current_exp_amount

	def put_back_current_exp_amount
		order_product.order_product_discounts.each do |op|
			op.reload_discount
			op.discount.current_expiration_amount += discount_quantity
			op.discount.save
		end
	end
end
