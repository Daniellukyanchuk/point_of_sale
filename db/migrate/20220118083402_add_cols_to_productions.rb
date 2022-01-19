class AddColsToProductions < ActiveRecord::Migration[5.2]
  change_table :productions do |t|
    t.integer :recipe_id
    t.float :recipe_cost
    t.integer :production_yield
  end
end
