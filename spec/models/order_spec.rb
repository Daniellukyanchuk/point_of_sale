require 'rails_helper'

  RSpec.describe Order, type: :model do

    it "should subtract the correct number of units from inventory, and put them back if the order is cancelled" do

      #create mock products for test
      poppyseed_muffins = Product.create!(product_name: "poppyseed_muffins", price: 60, grams_per_unit: 110, unit: "muffin")
      fairy_dust = Product.create!(product_name: "fairy_dust", price: 3000, grams_per_unit: 50, unit: "vial")
      #create mock client
      scrooge_mc_duck = Client.create!(name: "Scrooge McDuck", phone: "+1 (836) 728 973", address: "353 Cabbage Ln.", city: "Las Vegas")
      
      #add products to inventory

      p1 = Inventory.create!(product_id: poppyseed_muffins.id, remaining_quantity: 25, production_id: 991)
      p2 = Inventory.create!(product_id: poppyseed_muffins.id, remaining_quantity: 40, production_id: 993)
      Inventory.create!(product_id: fairy_dust.id, remaining_quantity: 10, production_id: 992)
      
      #create mock order for test
      order = Order.create!(client_id: scrooge_mc_duck.id, order_products: 
        [
        OrderProduct.new(product_id: poppyseed_muffins.id, quantity: 35, sale_price: 65), 
        OrderProduct.new(product_id: fairy_dust.id, quantity: 3, sale_price: 2900)
        ])

      expect(Inventory.find(p1.id).remaining_quantity).to eq(0)
      expect(Inventory.find(p2.id).remaining_quantity).to eq(30)

      expect(Inventory.where(product_id: poppyseed_muffins.id).sum(:remaining_quantity)).to eq(30)
      expect(Inventory.where(product_id: fairy_dust.id).sum(:remaining_quantity)).to eq(7)      
      
      
      order.destroy!

      expect(Inventory.where(product_id: poppyseed_muffins.id).sum(:remaining_quantity)).to eq(65)
    end
end

