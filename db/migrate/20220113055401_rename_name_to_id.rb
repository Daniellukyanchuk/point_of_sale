class RenameNameToId < ActiveRecord::Migration[5.2]
  
  def change
    rename_column :recipes, :recipe_name, :product_id
  end
end
