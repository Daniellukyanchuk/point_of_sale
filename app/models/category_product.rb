class CategoryProduct < ApplicationRecord
    belongs_to :product
    belongs_to :product_category
end
