class ChangeName < ActiveRecord::Migration[5.2]
  def change
    remove_column :inventories, :supply_id
    add_column :inventories, :purchase_id, :integer
  end
end
