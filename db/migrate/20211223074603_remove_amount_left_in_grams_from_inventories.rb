class RemoveAmountLeftInGramsFromInventories < ActiveRecord::Migration[5.2]
  def change
    remove_column :inventories, :amount_left_in_grams, :decimal
  end
end
