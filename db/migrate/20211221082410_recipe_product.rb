class RecipeProduct < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_products do |t|
      t.integer :recipe_id
      t.integer :product_id
      t.decimal :product_amount
      t.decimal :product_price
      t.decimal :product_subtotal

      t.timestamps
    end
  end
end
