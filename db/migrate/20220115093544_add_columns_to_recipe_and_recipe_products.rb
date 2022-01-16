class AddColumnsToRecipeAndRecipeProducts < ActiveRecord::Migration[5.2]
   change_table :recipes do |t|
    t.string :units
  end
  change_table :recipe_products do |t|
    t.float :cost_per_kg
  end
end
