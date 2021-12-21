class RecipeProduct < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_products do |t|
      t.integer :recipe_id
      t.string :ingredient_name
      t.decimal :quantity_amount
      t.decimal :ingredient_subtotal

      t.timestamps
    end
  end
end
