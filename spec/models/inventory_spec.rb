require 'rails_helper'
# require 'inventory'

# Trying to figure out how to write test to check if add_inventory is working properly. 
RSpec.describe Inventory, type: :model do

    it 'adds correct amount to the inventory' do       
      prod = Product.create(product_name: "muffin", price: 50, unit: "piece")
      # there are no muffins in inventory

      inventory_add = Inventory.add_inventory(prod.id, 75, 48)

      # check to see that you have the exact number of added muffins in inventory
      expect(inventory_add.id.to_i > 0).to eq(true) 

      # check to see if there are 75 muffins
      expect(Inventory.where('product_id = ?', prod.id).sum(:amount)).to eq(75)

    end
end

# What matcher do I use to find out if I have the exact number of added muffins in inventory? 
# How should the testing code look like? 