require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it "searches for multiple orders by client's name" do  
    shibon = Supplier.create!(suppliers_name: "Shibon")
    sierra = Supplier.create!(suppliers_name: "Sierra")
    market = Supplier.create!(suppliers_name: "Market")

    muffins = Product.create!(product_name: "muffins", price: 50)
    tartlet = Product.create!(product_name: "tartlet", price: 60)

  

    purchase = Purchase.create!(supplier_id: shibon.id, purchase_products: [
          PurchaseProduct.new(product_id: muffins.id, estimated_quantity: 5, estimated_price_per_unit: 50),
          PurchaseProduct.new(product_id: tartlet.id, estimated_quantity: 5, estimated_price_per_unit: 60)])

    purchase_2 = Purchase.create!(supplier_id: sierra.id, purchase_products: [
            PurchaseProduct.new(product_id: muffins.id, estimated_quantity: 5, estimated_price_per_unit: 50),
            PurchaseProduct.new(product_id: tartlet.id, estimated_quantity: 5, estimated_price_per_unit: 60)])

    purchase_3 = Purchase.create!(supplier_id: market.id, purchase_products: [
            PurchaseProduct.new(product_id: muffins.id, estimated_quantity: 5, estimated_price_per_unit: 50),
            PurchaseProduct.new(product_id: tartlet.id, estimated_quantity: 5, estimated_price_per_unit: 60)])

    purchases = Purchase.search("", [shibon.id.to_s, sierra.id.to_s, market.id.to_s], "14-01-2022", "14-02-2022").order('id')


    expect(purchases.length).to eq(3)
    expect(purchases.first.supplier_id).to eq(shibon.id)
    expect(purchases[1].supplier.suppliers_name).to eq("Sierra")


  end
end
