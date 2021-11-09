class AddSupplyProduct < ActiveRecord::Migration[5.2]
  def change
    create_table :supply_products do |t|
      t.integer :product_id
      t.integer :supply_id
      t.float :purchase_quantity
      t.float :purchase_price
      t.float :purchase_subtotal

      t.timestamps
    end
  end
end
