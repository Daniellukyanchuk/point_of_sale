class ChangeInventoryTable < ActiveRecord::Migration[5.2]
  change_table :inventory_records do |t|
    t.remove :date_added
    t.integer :supply_product_id
  end
end
