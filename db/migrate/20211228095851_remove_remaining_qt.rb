class RemoveRemainingQt < ActiveRecord::Migration[5.2]
  change_table :purchase_products do |t|
    t.remove :remaining_quantity
    
  end
end
