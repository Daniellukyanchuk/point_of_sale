class AddColumnToSupplyProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :supply_products, :remaining_quantity, :float
  end
end
