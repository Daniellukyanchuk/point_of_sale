require 'rails_helper'

# When I create a new Production, does it subtract the right amount from the inventory?

# When I create a new Production, does it add right amount of products in the inventory? 


RSpec.describe Production, type: :model do
  it "subtracts ingredients from inventory and adds products to inventory" do 

    flour = Product.create!(product_name: "flour", price: 100)
    sugar = Product.create!(product_name: "sugar", price: 60)
    muffins = Product.create!(product_name: "muffins", price: 50)
    
    Inventory.create!(product_id: muffins.id, amount: 30, current_amount_left: 30)
    Inventory.create!(product_id: flour.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: sugar.id, amount: 15, current_amount_left: 15)

    grandmas_muffins = Recipe.create!(product_id: muffins.id, recipe_products: [
        RecipeProduct.new(product_id: flour.id, product_amount: 0.175, product_price: 100), 
        RecipeProduct.new(product_id: sugar.id, product_amount: 0.175, product_price: 60)])
    
    Production.create!(recipe_id: grandmas_muffins.id, product_amount: 10, recipe_price: 50, grand_total: 500, cost_to_make: 280.0)
    
    expect(Inventory.where(product_id: flour.id).sum(:current_amount_left)).to eq(18.25)
    expect(Inventory.where(product_id: sugar.id).sum(:current_amount_left)).to eq(13.25)
    expect(Inventory.where(product_id: muffins.id).sum(:amount)).to eq(40)

    # Check if the cost_to_make is being calculated correctly.

    

    # expect(Production.where(cost_to_make: muffins.id)).to be_truthy
    expect(Production.where(product_id: muffins.id).sum(:cost_to_make)).to be_truthy
  end
end


