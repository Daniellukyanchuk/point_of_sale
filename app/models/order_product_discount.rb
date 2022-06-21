class OrderProductDiscount < ApplicationRecord
	belongs_to :discount
	belongs_to :order_product 
end
