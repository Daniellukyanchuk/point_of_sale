class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.float :recipe_cost
      t.integer :yield
      t.text :instructions

      t.timestamps
    end
  end
end
