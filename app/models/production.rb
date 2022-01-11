class Production < ApplicationRecord
	has_many :recipe_products
	has_one :recipe
end
