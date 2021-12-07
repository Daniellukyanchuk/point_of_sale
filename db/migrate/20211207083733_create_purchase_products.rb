class CreatePurchaseProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_products do |t|
      t.integer :purchase_id
      t.integer :product_id
      t.decimal :estimated_quantity
      t.decimal :actual_quantity
      t.decimal :estimated_price_per_unit
      t.decimal :actual_price_per_unit
      t.decimal :estimated_subtotal
      t.decimal :actual_subtotal
    end
  end
end
