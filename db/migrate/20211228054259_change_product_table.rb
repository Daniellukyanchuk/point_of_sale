class ChangeProductTable < ActiveRecord::Migration[5.2]
  change_table :products do |t|
    t.remove :inventory
    t.float :grams_per_unit  
  end
end
