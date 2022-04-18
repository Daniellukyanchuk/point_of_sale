class CreateAddInventoryTables < ActiveRecord::Migration[5.2]

  def change
    remove_column :supply_products, :remaining_quantity, :float
  end

  # def change
  #   create_table :inventory_records do |t|
  #       t.integer :supply_id
  #       t.integer :product_id
  #       t.float :remaining_quantity
  #       t.date :date_received

  #     t.timestamps
  #   end
  # end
end
