class CreateOrderProductDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_product_discounts do |t|
      t.integer :discount_id
      t.integer :order_product_id
      t.decimal :discount_quantitu

      t.timestamps
    end
  end
end
