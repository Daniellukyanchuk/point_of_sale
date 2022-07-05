require 'rails_helper'


# rspec spec/models/order_spec.rb
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

  # rspec -e"if there is no client_discount"
  it "if there is no client_discount" do 
    # First case: When there is one discount.
    sianna_marie = Client.create!(name: "Sianna-Marie")

    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: croissant.id, amount: 20, current_amount_left: 20)

    order = Order.create!(client_id: sianna_marie.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50, client_discount: 0),
      OrderProduct.new(product_id: croissant.id, quantity: 4, sale_price: 100, client_discount: 0)
      ])

    expect(order.order_products[0].subtotal.to_s).to eq("250.0")
    expect(order.order_products[1].subtotal.to_s).to eq("400.0")
    expect(order.grand_total.to_s).to eq("650.0") 
  end
  
  # rspec -e"if there is one or multiple client_discounts"
  it "if there is one or multiple client_discounts" do 
    # Second case: When there are multiple discounts. 
    # If there is no more current_expiration_amount left in the first discount, then go to the 
    # next discount if there is one.
    sianna_marie = Client.create!(name: "Sianna-Marie")

    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 1000, current_amount_left: 1000)
    Inventory.create!(product_id: croissant.id, amount: 1000, current_amount_left: 1000)

    discount_1 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 1, expiration_amount: 250, current_expiration_amount: 250, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    discount_2 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.75, expiration_amount: 500, current_expiration_amount: 500, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    discount_3 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.5, expiration_amount: 1000, current_expiration_amount: 1000, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')

    order = Order.create!(client_id: sianna_marie.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 500, sale_price: 50, client_discount: 1),
      OrderProduct.new(product_id: croissant.id, quantity: 500, sale_price: 100, client_discount: 1)
      ])


    
    # Check if the subtotal is being calculated correctly after the client_discount is applied. 
    expect(order.order_products[0].subtotal.round(2)).to eq(24562.5.round(2))
    expect(order.order_products[1].subtotal.round(2)).to eq(49687.5.round(2))
    expect(order.grand_total.round(2)).to eq(74250.round(2))
    
    expect(Discount.find(discount_1.id).current_expiration_amount.to_s).to eq("0.0")
    expect(Discount.find(discount_2.id).current_expiration_amount.to_s).to eq("0.0")
    expect(Discount.find(discount_3.id).current_expiration_amount.to_s).to eq("750.0")
  end
  
  # rspec -e"if the order was deleted, the current_expiration_amount is being put back"
  it "if the order was deleted, the current_expiration_amount is being put back" do 

    sianna_marie = Client.create!(name: "Sianna-Marie")

    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: croissant.id, amount: 20, current_amount_left: 20)

    discount_1 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.5, expiration_amount: 10, current_expiration_amount: 10, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    discount_2 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.5, expiration_amount: 15, current_expiration_amount: 15, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')

    order = Order.create!(client_id: sianna_marie.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50, client_discount: 0.5),
      OrderProduct.new(product_id: croissant.id, quantity: 6, sale_price: 100, client_discount: 0.5)
      ])
    
    expect(OrderProductDiscount.count).to eq(3)
    expect(OrderProductDiscount.last.discount_quantity.round(2)).to eq(1)
    
    order.destroy

    expect(Discount.find(discount_1.id).current_expiration_amount.to_s).to eq("10.0")
    expect(Discount.find(discount_2.id).current_expiration_amount.to_s).to eq("15.0")
  end
  
  # rspec -e"if the client_discount is updated, the current_expiration_amount is either being put back or subtracted more"
  it "if the client_discount is updated, the current_expiration_amount is either being put back or subtracted more" do 

    sianna_marie = Client.create!(name: "Sianna-Marie")

    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: croissant.id, amount: 20, current_amount_left: 20)

    discount_1 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.5, expiration_amount: 10, current_expiration_amount: 10, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    discount_2 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.5, expiration_amount: 15, current_expiration_amount: 15, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')

    order = Order.create!(client_id: sianna_marie.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50, client_discount: 0.5),
      OrderProduct.new(product_id: croissant.id, quantity: 4, sale_price: 100, client_discount: 0.5)
      ])
    
    order.client_id = sianna_marie.id
    order.order_products.first.assign_attributes({product_id: muffins.id, quantity: 10, sale_price: 50, client_discount: 0.5})
    order.order_products.last.assign_attributes({product_id: croissant.id, quantity: 4, sale_price: 100, client_discount: 0.5})
    order.save

    expect(Discount.find(discount_1.id).current_expiration_amount.to_s).to eq("0.0")
    expect(Discount.find(discount_2.id).current_expiration_amount.to_s).to eq("11.0")
  end
  
  # rspec -e"if a client has a discount for less then he orders"
  it "if a client has a discount for less then he orders" do 
  # Bob has a discount for 500, he makes an order for 400 and then updates the order to the 600. Does he get his 500 discount right? 
  
    vladimir = Client.create!(name: "Vladimir")
    
    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 1000, current_amount_left: 1000)
    Inventory.create!(product_id: croissant.id, amount: 1000, current_amount_left: 1000)

    discount_1 = Discount.create!(client_id: vladimir.id, discount_per_kilo: 0.5, expiration_amount: 500, current_expiration_amount: 500, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    
    order = Order.create!(client_id: vladimir.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 200, sale_price: 50, client_discount: 0.5),
      OrderProduct.new(product_id: croissant.id, quantity: 200, sale_price: 100, client_discount: 0.5)
      ])

    expect(order.order_products[0].subtotal.to_s).to eq("9900.0")
    expect(order.order_products[1].subtotal.to_s).to eq("19900.0")
    expect(order.grand_total.to_s).to eq("29800.0")
    
    order.client_id = vladimir.id
    order.order_products.first.assign_attributes({product_id: muffins.id, quantity: 300, sale_price: 50, client_discount: 0.5})
    order.order_products.last.assign_attributes({product_id: croissant.id, quantity: 300, sale_price: 100, client_discount: 0.5})
    order.save

    # Check if only 500 units got a discount and other 100 didn't
    expect(order.order_products[0].subtotal.to_s).to eq("14850.0")
    expect(order.order_products[1].subtotal.to_s).to eq("29900.0")
    expect(order.grand_total.to_s).to eq("44750.0")
  end
  
  # rspec -e"match the discounts only with the current discounts, not expired or not started once"
  it "match the discounts only with the current discounts, not expired or not started once" do
    vladimir = Client.create!(name: "Vladimir")
    
    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 1000, current_amount_left: 1000)
    Inventory.create!(product_id: croissant.id, amount: 1000, current_amount_left: 1000)

    discount_1 = Discount.create!(client_id: vladimir.id, discount_per_kilo: 0.5, expiration_amount: 250, current_expiration_amount: 250, starting_date: '2022-04-23'.to_date, ending_date: '2022-05-23')
    discount_2 = Discount.create!(client_id: vladimir.id, discount_per_kilo: 0.5, expiration_amount: 500, current_expiration_amount: 500, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    discount_3 = Discount.create!(client_id: vladimir.id, discount_per_kilo: 0.5, expiration_amount: 1000, current_expiration_amount: 1000, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')

    order = Order.create!(client_id: vladimir.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 300, sale_price: 50, client_discount: 0.5),
      OrderProduct.new(product_id: croissant.id, quantity: 300, sale_price: 100, client_discount: 0.5)
      ])

    expect(Discount.find(discount_1.id).current_expiration_amount.to_s).to eq("250.0")
    expect(Discount.find(discount_2.id).current_expiration_amount.to_s).to eq("0.0")
  end
  
  # rspec -e"multiple updates"
  it "multiple updates" do 
    sianna_marie = Client.create!(name: "Sianna-Marie")

    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 1000, current_amount_left: 1000)
    Inventory.create!(product_id: croissant.id, amount: 1000, current_amount_left: 1000)

    discount_1 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.5, expiration_amount: 200, current_expiration_amount: 200, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    discount_2 = Discount.create!(client_id: sianna_marie.id, discount_per_kilo: 0.5, expiration_amount: 300, current_expiration_amount: 300, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    
    # first current_expiration_amount should equal 110 after the order is created. 
    order = Order.create!(client_id: sianna_marie.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 50, sale_price: 50, client_discount: 0.5),
      OrderProduct.new(product_id: croissant.id, quantity: 40, sale_price: 100, client_discount: 0.5)
      ])

    expect(Discount.find(discount_1.id).current_expiration_amount.to_s).to eq("110.0")
    expect(Discount.find(discount_2.id).current_expiration_amount.to_s).to eq("300.0")

    # after update, first current_expiration_amount should equal 85
    order.client_id = sianna_marie.id
    order.order_products.first.assign_attributes({product_id: muffins.id, quantity: 60, sale_price: 50, client_discount: 0.5})
    order.order_products.last.assign_attributes({product_id: croissant.id, quantity: 55, sale_price: 100, client_discount: 0.5})
    order.save

    expect(Discount.find(discount_1.id).current_expiration_amount.to_s).to eq("85.0")
    expect(Discount.find(discount_2.id).current_expiration_amount.to_s).to eq("300.0")
    
    # after update, the first current_expiration_amount should equal 0.0, the second should equal 200.0. 
    order.client_id = sianna_marie.id
    order.order_products.first.assign_attributes({product_id: muffins.id, quantity: 100, sale_price: 50, client_discount: 0.5})
    order.order_products.last.assign_attributes({product_id: croissant.id, quantity: 200, sale_price: 100, client_discount: 0.5})
    order.save

    expect(Discount.find(discount_1.id).current_expiration_amount.to_s).to eq("0.0")
    expect(Discount.find(discount_2.id).current_expiration_amount.to_s).to eq("200.0")
  end
  
  # rspec -e"when client_id is changed, delete everything and run the code"
  it "when client_id is changed, delete everything and run the code" do 
    vladimir = Client.create!(name: "Vladimir")
    bob_marley = Client.create!(name: "Bob Marley")
    
    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 1000, current_amount_left: 1000)
    Inventory.create!(product_id: croissant.id, amount: 1000, current_amount_left: 1000)

    discount_1 = Discount.create!(client_id: vladimir.id, discount_per_kilo: 0.5, expiration_amount: 500, current_expiration_amount: 500, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    discount_2 = Discount.create!(client_id: bob_marley.id, discount_per_kilo: 0.5, expiration_amount: 600, current_expiration_amount: 500, starting_date: '2022-06-23'.to_date, ending_date: '2022-07-23')
    
    order = Order.create!(client_id: vladimir.id, order_products: [
      OrderProduct.new(product_id: muffins.id, quantity: 200, sale_price: 50, client_discount: 0.5),
      OrderProduct.new(product_id: croissant.id, quantity: 200, sale_price: 100, client_discount: 0.5)
      ])

    expect(Discount.find(discount_1.id).current_expiration_amount.to_s).to eq("100.0")
    expect(Discount.find(discount_2.id).current_expiration_amount.to_s).to eq("600.0")
    
    order.client_id = bob_marley.id
    order.order_products.first.assign_attributes({product_id: muffins.id, quantity: 300, sale_price: 50, client_discount: 0.5})
    order.order_products.last.assign_attributes({product_id: croissant.id, quantity: 300, sale_price: 100, client_discount: 0.5})
    order.save

    expect(Discount.find(discount_1.id).current_expiration_amount.to_s).to eq("500.0")
    expect(Discount.find(discount_2.id).current_expiration_amount.to_s).to eq("0.0")
  end

  # rspec -e"different discount systems integrate with each other"
  it "different discount systems integrate with each other" do 
    # the discount for individual order_product.
    sianna_marie = Client.create!(name: "Sianna-Marie")

    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: croissant.id, amount: 20, current_amount_left: 20)

    order = Order.create!(client_id: sianna_marie.id, order_products: [
          OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50, discount: 5),
          OrderProduct.new(product_id: croissant.id, quantity: 4, sale_price: 100)
        ])

    expect(order.order_products[0].subtotal).to eq(225)
    expect(order.order_products[1].subtotal).to eq(400)
  end
  # rspec -e"percentage_of_total changes if discount: 5"
  it "percentage_of_total changes if discount: 5" do 
    sianna_marie = Client.create!(name: "Sianna-Marie")

    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: croissant.id, amount: 20, current_amount_left: 20)

    order = Order.create!(client_id: sianna_marie.id, order_products: [
          OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50),
          OrderProduct.new(product_id: croissant.id, quantity: 4, sale_price: 100)
        ], order_discount: 20)
  
    expect(order.order_products[0].percentage_of_total.round(2)).to eq(0.38.round(2))
    expect(order.order_products[0].discount_to_apply.round(2)).to eq(7.69.round(2))
    expect(order.order_products[0].discount_per_unit.round(2)).to eq(1.54.round(2))
    expect(order.order_products[0].subtotal.round(2)).to eq(242.31.round(2))

    expect(order.order_products[1].percentage_of_total.round(2)).to eq(0.62.round(2))
    expect(order.order_products[1].discount_to_apply.round(2)).to eq(12.31.round(2))
    expect(order.order_products[1].discount_per_unit.round(2)).to eq(3.08.round(2))
    expect(order.order_products[1].subtotal.round(2)).to eq(387.69.round(2))
    expect(order.grand_total).to eq(630.0)
  end
  
  # rspec -e"combining two systems"
  it "combining two systems" do 
    # the discount for individual order_product.
    sianna_marie = Client.create!(name: "Sianna-Marie")

    muffins = Product.create!(product_name: "muffins", price: 50)
    croissant = Product.create!(product_name: "croissant", price: 100)

    Inventory.create!(product_id: muffins.id, amount: 20, current_amount_left: 20)
    Inventory.create!(product_id: croissant.id, amount: 20, current_amount_left: 20)

    order = Order.create!(client_id: sianna_marie.id, order_products: [
          OrderProduct.new(product_id: muffins.id, quantity: 5, sale_price: 50, discount: 5),
          OrderProduct.new(product_id: croissant.id, quantity: 4, sale_price: 100)
        ], order_discount: 20)

    expect(order.order_products[0].subtotal).to eq(217.8)
    expect(order.order_products[1].subtotal).to eq(387.2)
    expect(order.grand_total).to eq(605.0)

    expect(order.order_products[0].percentage_of_total.round(2)).to eq(0.36.round(2))
    expect(order.order_products[0].discount_to_apply.round(2)).to eq(7.2.round(2))
    expect(order.order_products[0].discount_per_unit.round(2)).to eq(1.44.round(2))

    expect(order.order_products[1].percentage_of_total.round(2)).to eq(0.64.round(2))
    expect(order.order_products[1].discount_to_apply.round(2)).to eq(12.8.round(2))
    expect(order.order_products[1].discount_per_unit.round(2)).to eq(3.2.round(2))
  end
end
