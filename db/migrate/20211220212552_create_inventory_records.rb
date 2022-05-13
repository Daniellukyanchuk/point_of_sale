class CreateInventoryRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory_records do |t|
        t.integer :supply_id
        t.integer :product_id
        t.float :remaining_quantity
        t.date :date_received

      t.timestamps
    end
  end
end
