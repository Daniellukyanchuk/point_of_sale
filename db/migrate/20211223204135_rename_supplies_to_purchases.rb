class RenameSuppliesToPurchases < ActiveRecord::Migration[5.2]
  
  def self.up
    rename_table :inventory_records, :inventories
    rename_table :supply_products, :purchase_products
    rename_table :supplies, :purchases
  end

  def self.down
    rename_table :purchases, :supplies
    rename_table :purchase_products, :supply_products
    rename_table :inventories, :inventory_records    
  end

end
