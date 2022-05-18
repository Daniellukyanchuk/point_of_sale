class CreateProductions < ActiveRecord::Migration[5.2]
  def change
    create_table :productions do |t|
      t.string :recipe_name
      t.float :production_quantity
      t.float :production_total_cost

      t.timestamps
    end
  end
end
