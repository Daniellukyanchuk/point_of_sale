class RecipeProduct < ApplicationRecord
    belongs_to :recipe
    belongs_to :product
    validates :amount, presence: true   
    
    attr_accessor :cost_per_kg
   
end