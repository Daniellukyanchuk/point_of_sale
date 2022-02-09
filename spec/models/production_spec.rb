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
    expect(Production.where(product_id: muffins.id).sum(:cost_to_make)).to be_truthy
  end 

  it 'checks if the number in cost_to_make is correct' do  
    flour = Product.create!(product_name: "flour", price: 100, unit: 1)
    sunflower_oil = Product.create!(product_name: "sunflower oil", price: 100, unit: 1)
    banana_bread = Product.create!(product_name: "banana bread", price: 250.0, unit: 1)

    Inventory.create!(product_id: banana_bread.id, amount:10, current_amount_left: 10)
    Inventory.create!(product_id: flour.id, amount:20, price_per_unit: 100)
    Inventory.create!(product_id: sunflower_oil.id, amount:30, price_per_unit:100)
    Inventory.create!(product_id: flour.id, amount:50, price_per_unit: 90)
    Inventory.create!(product_id: sunflower_oil.id, amount: 40, price_per_unit: 85)

    joergs_banana_bread = Recipe.create!(product_id: banana_bread.id, recipe_products: [
           RecipeProduct.new(product_id: flour.id, product_amount: 0.4, product_price: 92.86),
           RecipeProduct.new(product_id: sunflower_oil.id, product_amount: 0.2, product_price: 91.43)])

    prod = Production.create!(recipe_id: joergs_banana_bread.id, product_amount: 10 )

    expect(prod.cost_to_make.round(2)).to eq(554.29)
  end
end


