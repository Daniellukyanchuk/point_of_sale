class ProductionRecipe < ApplicationRecord
  belongs_to :production
  belongs_to :recipe
end