require 'rails_helper'

RSpec.describe Order, type: :model do
  it "subtracts products from inventory" do 
    maxim = Client.create!(name: "Maxim", city: "Osh")

    muffins = Product.create!(product_name: "muffins", price: 50)
    banana_bread = Product.create!(product_name: "banana_bread", price: 250)

    Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: banana_bread.id, amount: 10, current_amount_left: 10)

    order = Order.create(client_id: maxim.id, order_products: [
          OrderProduct.new(product_id: muffins.id, quantity: 10, sale_price: 50, subtotal: 500),
          OrderProduct.new(product_id: banana_bread.id, quantity: 5,  sale_price: 250, subtotal: 1250)], grand_total: 1750)

    expect(Inventory.where(product_id: muffins.id).sum(:current_amount_left)).to eq(10)
    expect(Inventory.where(product_id: banana_bread.id).sum(:current_amount_left)).to eq(5)

    order.destroy

    expect(Inventory.where(product_id: muffins.id).sum(:current_amount_left)).to eq(20)
    
  end

  it "searches for multiple orders by client's name" do  
    maxim = Client.create!(name: "Maxim")
    john = Client.create!(name: "John")
    harold = Client.create!(name: "Harold")

    muffins = Product.create!(product_name: "muffins", price: 50)
    tartlet = Product.create!(product_name: "tartlet", price: 60)

    Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: tartlet.id, amount: 20, current_amount_left: 20)

    order = Order.create!(client_id: maxim.id, order_products: [
          OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50),
          OrderProduct.new(product_id: tartlet.id, quantity: 5, sale_price: 60)])

    order_2 = Order.create!(client_id: john.id, order_products: [
            OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50),
            OrderProduct.new(product_id: tartlet.id, quantity: 5, sale_price: 60)])

    order_3 = Order.create!(client_id: harold.id, order_products: [
            OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50),
            OrderProduct.new(product_id: tartlet.id, quantity: 5, sale_price: 60)])

    orders = Order.search("", [maxim.id.to_s, john.id.to_s, harold.id.to_s], "14-01-2022", "14-02-2022").order('id')


    expect(orders.length).to eq(3)
    expect(orders.first.client_id).to eq(maxim.id)
    expect(orders[1].client.name).to eq("John")


  end
end
