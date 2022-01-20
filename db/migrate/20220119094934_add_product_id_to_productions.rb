class AddProductIdToProductions < ActiveRecord::Migration[5.2]
  def change
    add_column :productions, :product_id, :integer
  end
end
