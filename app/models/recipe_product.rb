class RecipeProduct < ApplicationRecord
    belongs_to :recipe
    has_one :product
    validates :amount, presence: true
    
    
    attr_accessor :cost_per_kg
   
end