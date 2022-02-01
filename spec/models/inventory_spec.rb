require 'rails_helper'
# require 'inventory'

RSpec.describe Inventory, type: :model do
 
    it 'adds correct amount to the inventory' do 
      
      prod = Product.create(product_name: "muffin", price: 50, unit: "piece")

      # there are no muffins in inventory
      expect()

      inventory_add = Inventory.add_inventory(prod.id, ?, ?)

      # check to see that you have the exact number of added muffins in inventory
      expect().to be > 0
    end
   
end
