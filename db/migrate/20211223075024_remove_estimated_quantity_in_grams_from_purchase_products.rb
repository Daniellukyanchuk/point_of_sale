class RemoveEstimatedQuantityInGramsFromPurchaseProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchase_products, :estimated_quantity_in_grams, :decimal
  end
end
