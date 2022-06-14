require 'rails_helper'

RSpec.describe Order, type: :model do
  # it "subtracts products from inventory" do 
  #   maxim = Client.create!(name: "Maxim", city: "Osh")

  #   muffins = Product.create!(product_name: "muffins", price: 50)
  #   banana_bread = Product.create!(product_name: "banana_bread", price: 250)

  #   Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
  #   Inventory.create!(product_id: banana_bread.id, amount: 10, current_amount_left: 10)

  #   order = Order.create(client_id: maxim.id, order_products: [
  #         OrderProduct.new(product_id: muffins.id, quantity: 10, sale_price: 50, subtotal: 500),
  #         OrderProduct.new(product_id: banana_bread.id, quantity: 5,  sale_price: 250, subtotal: 1250)], grand_total: 1750)

  #   expect(Inventory.where(product_id: muffins.id).sum(:current_amount_left)).to eq(10)
  #   expect(Inventory.where(product_id: banana_bread.id).sum(:current_amount_left)).to eq(5)

  #   order.destroy

  #   expect(Inventory.where(product_id: muffins.id).sum(:current_amount_left)).to eq(20)  
  # end

  # it "searches for multiple orders by client's name" do  
  #   maxim = Client.create!(name: "Maxim")
  #   john = Client.create!(name: "John")
  #   harold = Client.create!(name: "Harold")

  #   muffins = Product.create!(product_name: "muffins", price: 50)
  #   tartlet = Product.create!(product_name: "tartlet", price: 60)

  #   Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
  #   Inventory.create!(product_id: tartlet.id, amount: 20, current_amount_left: 20)

  #   order = Order.create!(client_id: maxim.id, order_products: [
  #         OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50),
  #         OrderProduct.new(product_id: tartlet.id, quantity: 5, sale_price: 60)])

  #   order_2 = Order.create!(client_id: john.id, order_products: [
  #           OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50),
  #           OrderProduct.new(product_id: tartlet.id, quantity: 5, sale_price: 60)])

  #   order_3 = Order.create!(client_id: harold.id, order_products: [
  #           OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50),
  #           OrderProduct.new(product_id: tartlet.id, quantity: 5, sale_price: 60)])

  #   orders = Order.search("", [maxim.id.to_s, john.id.to_s, harold.id.to_s], "14-01-2022", "14-02-2022").order('id')


  #   expect(orders.length).to eq(3)
  #   expect(orders.first.client_id).to eq(maxim.id)
  #   expect(orders[1].client.name).to eq("John")
  # end

  it "checks if the discounts are calculated right" do 
    sianna_marie = Client.create!(name: "Sianna-Marie")

    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: croissant.id, amount: 20, current_amount_left: 20)

    order = Order.create!(client_id: sianna_marie.id, order_products: [
          OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50),
          OrderProduct.new(product_id: croissant.id, quantity: 4, sale_price: 100)
        ], order_discount: 20)
  
    expect(order.order_products[0].percentage_of_total.to_s).to eq("0.384615384615385")
    expect(order.order_products[0].discount_to_apply.to_s).to eq("7.6923076923077")
    expect(order.order_products[0].discount_per_unit.to_s).to eq("1.53846153846154")

    expect(order.order_products[1].percentage_of_total.to_s).to eq("0.615384615384615")
    expect(order.order_products[1].discount_to_apply.to_s).to eq("12.3076923076923")
    expect(order.order_products[1].discount_per_unit.to_s).to eq("3.076923076923075")
  end
end
