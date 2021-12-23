class RemoveAmountPurchasedInGramsFromInventories < ActiveRecord::Migration[5.2]
  def change
    remove_column :inventories, :amount_purchased_in_grams, :decimal
  end
end
