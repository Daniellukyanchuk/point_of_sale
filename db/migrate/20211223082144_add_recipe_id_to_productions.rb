class AddRecipeIdToProductions < ActiveRecord::Migration[5.2]
  def change
    add_column :productions, :recipe_id, :integer
  end
end
