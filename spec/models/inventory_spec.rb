require 'rails_helper'
# require 'inventory'

RSpec.describe Inventory, type: :model do
    it 'adds correct amount to the inventory' do       
      prod = Product.create(product_name: "muffin", price: 50, unit: "piece")
      # there are no muffins in inventory

      inventory_add = Inventory.add_inventory(prod.id, prod.amount, prod.recipe_price)

      # check to see that you have the exact number of added muffins in inventory
      expect(inventory_add).to eq(true) 
    end
end
