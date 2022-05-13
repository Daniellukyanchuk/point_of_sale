class AddRecipeProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_products do |t|
      t.integer :product_id
      t.float :amount
      t.float :ingredient_total

      t.timestamps
  end

  def change
    add_column :products, :grams_per_unit, :float
  end

end
end