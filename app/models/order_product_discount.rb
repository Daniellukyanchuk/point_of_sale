class OrderProductDiscount < ApplicationRecord
    belongs_to :client_discount
    belongs_to :order_product
end