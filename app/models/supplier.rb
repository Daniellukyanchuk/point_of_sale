class Supplier < ApplicationRecord
    has_many :supplies
    has_many :supply_products, through: :supplies
    has_many :products, through: :supply_products
end
