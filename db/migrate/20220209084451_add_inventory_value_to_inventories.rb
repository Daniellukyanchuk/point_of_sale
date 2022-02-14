class AddInventoryValueToInventories < ActiveRecord::Migration[5.2]
  def change
    add_column :inventories, :cost_per_unit, :float
  end
end
