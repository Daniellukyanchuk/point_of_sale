class AddAmountLeftInGramsToInventories < ActiveRecord::Migration[5.2]
  def change
    add_column :inventories, :amount_left_in_grams, :decimal
  end
end
