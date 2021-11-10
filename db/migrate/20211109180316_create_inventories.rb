class CreateInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories do |t|
      t.integer :product_id
      t.date :date
      t.integer :amount
      t.decimal :price_per_unit
      t.decimal :costs
      t.decimal :current_amount_left
      t.decimal :value_of_item

      t.timestamps
    end
  end
end
