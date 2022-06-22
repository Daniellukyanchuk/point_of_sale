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

  # it "checks if the discounts are calculated right" do 
  #   sianna_marie = Client.create!(name: "Sianna-Marie")

  #   muffins = Product.create!(product_name: "muffins", price: 50)
  #   croissant = Product.create!(product_name: "croissant", price: 100)

  #   Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
  #   Inventory.create!(product_id: croissant.id, amount: 20, current_amount_left: 20)

  #   order = Order.create!(client_id: sianna_marie.id, order_products: [
  #         OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50),
  #         OrderProduct.new(product_id: croissant.id, quantity: 4, sale_price: 100)
  #       ], order_discount: 20)
  
  #   expect(order.order_products[0].percentage_of_total.to_s).to eq("0.384615384615385")
  #   expect(order.order_products[0].discount_to_apply.to_s).to eq("7.6923076923077")
  #   expect(order.order_products[0].discount_per_unit.to_s).to eq("1.53846153846154")

  #   expect(order.order_products[1].percentage_of_total.to_s).to eq("0.615384615384615")
  #   expect(order.order_products[1].discount_to_apply.to_s).to eq("12.3076923076923")
  #   expect(order.order_products[1].discount_per_unit.to_s).to eq("3.076923076923075")
  # end

  it "if there is no client_discount" do 
    # First case: When there is one discount.
    sianna_marie = Client.create!(name: "Sianna-Marie")

    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: croissant.id, amount: 20, current_amount_left: 20)

    order = Order.create!(client_id: sianna_marie.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50, subtotal: 250, client_discount: 0),
      OrderProduct.new(product_id: croissant.id, quantity: 4, sale_price: 100, subtotal: 400, client_discount: 0)
      ], grand_total: 650)

    expect(order.order_products[0].subtotal.to_s).to eq("250")
    expect(order.order_products[1].subtotal.to_s).to eq("400")
    expect(order.grand_total.to_s).to eq("650")
     
    # client_discount * quantity, the sum of that subtracted from subtotal. 
  end

  it "if there is one or multiple client_discounts" do 

    # Second case: When there are multiple discounts. 
    # If there is no more current_expiration_amount left in the first discount, then go to the 
    # next discount if there is one.
    sianna_marie = Client.create!(name: "Sianna-Marie")

    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: croissant.id, amount: 20, current_amount_left: 20)

    discount_1 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.5, expiration_amount: 10, current_expiration_amount: 10, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    discount_2 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.5, expiration_amount: 15, current_expiration_amount: 15, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')

    order = Order.create!(client_id: sianna_marie.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50, subtotal: 250, client_discount: 0.5),
      OrderProduct.new(product_id: croissant.id, quantity: 4, sale_price: 100, subtotal: 400, client_discount: 0.5)
      ], grand_total: 645.5)

    order.save
    
    # Check if the subtotal is being calculated correctly after the client_discount is applied. 
    expect(order.order_products[0].subtotal.to_s).to eq("247.5")
    expect(order.order_products[1].subtotal.to_s).to eq("398")
    expect(order.grand_total.to_s).to eq("645.5")
    
    # I need to check if current_expiration_amount is 41 after creating an order. 
    expect(discount_1.current_expiration_amount.to_s).to eq("0")
    expect(discount_2.current_expiration_amount.to_s).to eq("7")

  end

  it "if the order was deleted, the current_expiration_amount is being put back" do 

    sianna_marie = Client.create!(name: "Sianna-Marie")

    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: croissant.id, amount: 20, current_amount_left: 20)

    discount_1 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.5, expiration_amount: 10, current_expiration_amount: 10, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    discount_2 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.5, expiration_amount: 15, current_expiration_amount: 15, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')

    order = Order.create!(client_id: sianna_marie.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50, subtotal: 250, client_discount: 0.5),
      OrderProduct.new(product_id: croissant.id, quantity: 6, sale_price: 100, subtotal: 400, client_discount: 0.5)
      ])

    order.destroy

    expect(discount_1.current_expiration_amount.to_s).to eq("10")
    expect(discount_2.current_expiration_amount.to_s).to eq("15")
  end

  it "if the client_discount is updated, the current_expiration_amount is either being put back or subtracted more" do 

    sianna_marie = Client.create!(name: "Sianna-Marie")

    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: croissant.id, amount: 20, current_amount_left: 20)

    discount_1 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.5, expiration_amount: 10, current_expiration_amount: 10, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    discount_2 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.5, expiration_amount: 15, current_expiration_amount: 15, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')

    order = Order.create!(client_id: sianna_marie.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50, subtotal: 250, client_discount: 0.5),
      OrderProduct.new(product_id: croissant.id, quantity: 4, sale_price: 100, subtotal: 400, client_discount: 0.5)
      ])

    order_update = order.update(client_id: sianna_marie.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 10, sale_price: 50, subtotal: 250, client_discount: 0.5),
      OrderProduct.new(product_id: croissant.id, quantity: 4, sale_price: 100, subtotal: 400, client_discount: 0.5)
      ])

    expect(discount_1.current_expiration_amount.to_s).to eq("0")
    expect(discount_2.current_expiration_amount.to_s).to eq("11")
  end

  # Bob has a discount for 500, he makes an order for 400 and then updates the order to the 600. Does he get his 500 discount right? 

  if "if a client has a discount for less then he orders" do 

    vladimir = Client.create!(name: "Vladimir")
    
    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 1000, current_amount_left: 1000)
    Inventory.create!(product_id: croissant.id, amount: 1000, current_amount_left: 1000)

    discount_1 = Discount.create!(client_id: vladimir.id, discount_per_kilo: 0.5, expiration_amount: 500, current_expiration_amount: 500, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    
    order = Order.create!(client_id: vladimir.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 200, sale_price: 50, subtotal: 10000, client_discount: 0.5),
      OrderProduct.new(product_id: croissant.id, quantity: 200, sale_price: 100, subtotal: 20000, client_discount: 0.5)
      ])

    order_update = order.update(client_id: vladimir.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 300, sale_price: 50, subtotal: 15000, client_discount: 0.5),
      OrderProduct.new(product_id: croissant.id, quantity: 300, sale_price: 100, subtotal: 30000, client_discount: 0.5)
      ])

    # Check if only 500 units got a discount and other 100 didn't

    

  end
end
