class RenameNameToId < ActiveRecord::Migration[5.2]
  
  def change
    remove_column :recipes, :recipe_name
    add_column :recipes, :product_id, :integer
  end
end
