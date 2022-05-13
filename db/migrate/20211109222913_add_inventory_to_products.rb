class AddInventoryToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :inventory, :string
  end
end
