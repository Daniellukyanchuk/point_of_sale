class Client < ApplicationRecord
    has_many :orders
    has_many :products, through: :order_products
    has_many :order_products, through: :orders
end
