class RecipeProduct < ApplicationRecord
    belongs_to :recipe
    belongs_to :product
    validates :amount, presence: true   
    
   
   
end