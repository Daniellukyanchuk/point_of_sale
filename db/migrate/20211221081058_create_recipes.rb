class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.string :cooking_instructions
      t.decimal :grand_total

      t.timestamps
    end
  end
end
