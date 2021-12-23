class RemoveRecipeIdFromProductions < ActiveRecord::Migration[5.2]
  def change
    remove_column :productions, :recipe_id, :integer
  end
end
