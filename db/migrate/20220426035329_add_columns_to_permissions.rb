class AddColumnsToPermissions < ActiveRecord::Migration[5.2]
  def change
    add_column :permissions, :all, :boolean
    add_column :permissions, :read, :boolean
    add_column :permissions, :write, :boolean
    add_column :permissions, :crush, :boolean
  end
end
