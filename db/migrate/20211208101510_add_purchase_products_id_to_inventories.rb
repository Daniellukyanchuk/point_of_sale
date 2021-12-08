class AddPurchaseProductsIdToInventories < ActiveRecord::Migration[5.2]
  def change
    add_column :inventories, :purchase_product_id, :integer
  end
end
