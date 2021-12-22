class CreateProductions < ActiveRecord::Migration[5.2]
  def change
    create_table :productions do |t|
      t.integer :recipe_id
      t.string :recipe_name
      t.decimal :grand_total

      t.timestamps
    end
  end
end
