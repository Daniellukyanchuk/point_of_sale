class Production < ApplicationRecord
	has_many :production_recipes, dependent: :delete_all
	accepts_nested_attributes_for :production_recipes, allow_destroy: true
end
