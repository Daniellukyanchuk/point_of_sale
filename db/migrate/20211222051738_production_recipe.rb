class ProductionRecipe < ActiveRecord::Migration[5.2]
  def change
    create_table :production_recipes do |t|
      t.integer :production_id
      t.integer :product_id
      t.integer :recipe_id
      t.decimal :product_amount
      t.decimal :recipe_price
      t.decimal :product_subtotal

      t.timestamps
    end
  end
end
