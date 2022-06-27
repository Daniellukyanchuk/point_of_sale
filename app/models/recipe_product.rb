class RecipeProduct < ApplicationRecord
    belongs_to :recipe
    belongs_to :product
    has_many :productions, through: :recipes
    validates :amount, presence: true
    validates :product_id, presence: { message: "Ingredient can't be blank!"}
       
end