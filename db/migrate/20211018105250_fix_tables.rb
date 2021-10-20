class FixTables < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :city

      t.timestamps
    end

    create_table :order_products do |t|
      t.integer :product_id
      t.integer :order_id
      t.float :quantity
      t.float :sale_price
      t.float :subtotal

      t.timestamps
    end

    create_table :orders do |t|
      t.integer :client_id
      t.float :grand_total

      t.timestamps
    end

    create_table :products do |t|
      t.string :product_name
      t.float :price
      t.string :unit

      t.timestamps
    end

  end
end
