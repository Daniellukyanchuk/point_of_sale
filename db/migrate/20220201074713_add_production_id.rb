class AddProductionId < ActiveRecord::Migration[5.2]
  def change
    add_column :inventories, :production_id, :integer
  end
end
