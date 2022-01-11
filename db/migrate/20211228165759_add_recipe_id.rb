class AddRecipeId < ActiveRecord::Migration[5.2]
  change_table :recipe_products do |t|
    t.integer :recipe_id
  end
end
