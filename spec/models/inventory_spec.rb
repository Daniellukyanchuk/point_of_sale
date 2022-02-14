require 'rails_helper'

  RSpec.describe Inventory, type: :model do

    it "should produce the right amount of poppyseed_muffins and remove the right amount of ingredients(recipe_products)" do

      #create mock products for test
      poppyseed_muffins = Product.create!(product_name: "poppyseed_muffins", price: 60, grams_per_unit: 110, unit: "muffin")
      flour = Product.create!(product_name: "flour", price: 38, grams_per_unit: 1000, unit: "kg")
      eggs = Product.create!(product_name: "eggs", price: 200, grams_per_unit: 1000, unit: "kg")
      

      #add products to inventory
            
      Inventory.create!(product_id: poppyseed_muffins.id, remaining_quantity: 100)
      f1 = Inventory.create!(product_id: flour.id, remaining_quantity: 2)
      f2 = Inventory.create!(product_id: flour.id, remaining_quantity: 3)
      Inventory.create!(product_id: eggs.id, remaining_quantity: 10)

      #create mock recipe for test
      best_poppyseed_muffin_recipe = Recipe.create!(product_id: poppyseed_muffins.id, yield: 12, recipe_products: 
        [
        RecipeProduct.new(product_id: flour.id, amount: 750), 
        RecipeProduct.new(product_id: eggs.id, amount: 250)
        ])

      Production.create!(recipe_id: best_poppyseed_muffin_recipe.id, production_quantity: 2, production_yield: 24, production_total_cost: 157)

      expect(Inventory.where(product_id: poppyseed_muffins.id).sum(:remaining_quantity)).to eq(124)
      expect(Inventory.where(product_id: flour.id).sum(:remaining_quantity)).to eq(3.5)
      expect(Inventory.where(product_id: eggs.id).sum(:remaining_quantity)).to eq(9.5)

      expect(Inventory.find(f1.id).remaining_quantity).to eq(0.5)
      expect(Inventory.find(f2.id).remaining_quantity).to eq(3)

    end
end


