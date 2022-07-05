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
    
    # rspec -e"should cycle through all available discounts until all units are discounted or there are no more available discounts"

    it "should cycle through all available discounts until all units are discounted or there are no more available discounts" do

      #create mock products for test
      poppyseed_muffins = Product.create!(product_name: "poppyseed_muffins", price: 50, grams_per_unit: 110, unit: "muffin")
      fairy_dust = Product.create!(product_name: "fairy_dust", price: 300, grams_per_unit: 50, unit: "vial")
      scrooge_mc_duck = Client.create!(name: "Scrooge McDuck", phone: "+1 (836) 728 973", address: "353 Cabbage Ln.", city: "Las Vegas")
      client_discount1 = ClientDiscount.create!(client_id: scrooge_mc_duck.id, discounted_units: 10, discounted_units_left: 10, discount_per_unit: 10)
      client_discount2 = ClientDiscount.create!(client_id: scrooge_mc_duck.id, discounted_units: 50, discounted_units_left: 50, discount_per_unit: 5)

      ord_1 = Order.create!(client_id: scrooge_mc_duck.id, order_products: 
        [
        OrderProduct.new(product_id: poppyseed_muffins.id, quantity: 20, sale_price: 50)
        # OrderProduct.new(product_id: fairy_dust.id, quantity: 10, sale_price: 300)
        ])

        expect(OrderProduct.where(order_id: ord_1.id).first.sale_price).to eq(42.5)
        expect(ClientDiscount.where(client_id: scrooge_mc_duck.id).sum(:discounted_units_left)).to eq(40)
        expect(Order.find(ord_1.id).grand_total).to eq(850)
        expect(OrderProductDiscount.all.sum(:discounted_qt)).to eq(20)
        expect(ClientDiscount.where(client_id: scrooge_mc_duck.id).sum(:discounted_units_left)).to eq(40)
        
      op = OrderProduct.where(order_id: ord_1.id)
      op.each do |rd|
        OrderProduct.return_discount(rd)
      end
      Order.destroy(ord_1.id)

        expect(Order.exists?(:client_id => scrooge_mc_duck.id)).to eq(false)
        expect(ClientDiscount.where(client_id: scrooge_mc_duck.id).sum(:discounted_units_left)).to eq(60)
    end
end
