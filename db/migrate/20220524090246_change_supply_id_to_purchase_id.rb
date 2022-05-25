class ChangeSupplyIdToPurchaseId < ActiveRecord::Migration[5.2]
  def change
    remove_column :inventories, :supply_product_id
    add_column :inventories, :purchase_product_id, :integer
  end
end

