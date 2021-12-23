class DropProductionRecipes < ActiveRecord::Migration[5.2]
  def change
    drop_table :production_recipes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end


