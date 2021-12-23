class RemoveProductIdFromProductionRecipes < ActiveRecord::Migration[5.2]
  def change
    remove_column :production_recipes, :product_id, :integer
  end
end
