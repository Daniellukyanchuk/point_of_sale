class RemoveRecipeIdFromProductionRecipes < ActiveRecord::Migration[5.2]
  def change
    remove_column :production_recipes, :recipe_id, :integer
  end
end
