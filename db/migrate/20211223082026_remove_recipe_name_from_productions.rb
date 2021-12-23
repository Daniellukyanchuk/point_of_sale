class RemoveRecipeNameFromProductions < ActiveRecord::Migration[5.2]
  def change
    remove_column :productions, :recipe_name, :string
  end
end
