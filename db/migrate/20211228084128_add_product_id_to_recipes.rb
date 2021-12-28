class AddProductIdToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :product_id, :integer
  end
end
