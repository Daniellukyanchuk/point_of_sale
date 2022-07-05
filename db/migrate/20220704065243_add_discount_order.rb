class AddDiscountOrder < ActiveRecord::Migration[5.2]
  def change
    create_table :order_product_discounts do |t|
      t.integer :client_discount_id
      t.integer :order_product_id
      t.integer :discounted_qt
      
      t.timestamps
    end
  end
end
