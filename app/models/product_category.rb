class ProductCategory < ApplicationRecord
    has_and_belongs_to_many :products, through: :category_products
    has_many :category_products
end
