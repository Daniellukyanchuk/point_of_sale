class AddAmountPurchasedInGramsToInventories < ActiveRecord::Migration[5.2]
  def change
    add_column :inventories, :amount_purchased_in_grams, :decimal
  end
end
