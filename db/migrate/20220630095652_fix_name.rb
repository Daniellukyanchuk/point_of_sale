class FixName < ActiveRecord::Migration[5.2]
  def change
    add_column :purchase_products, :purchase_id, :integer
    remove_column :purchase_products, :supply_id

    add_column :inventories, :purchase_id, :integer
    remove_column :inventories, :supply_id

    add_column :inventories, :purchase_product_id, :integer
    remove_column :inventories, :supply_product_id
  end
end
