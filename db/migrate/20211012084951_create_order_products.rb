class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity
      t.float :sale_price
      t.float :subtotal

      t.timestamps
    end
  end
end
