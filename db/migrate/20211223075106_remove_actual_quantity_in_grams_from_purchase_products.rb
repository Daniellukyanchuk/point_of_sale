class RemoveActualQuantityInGramsFromPurchaseProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchase_products, :actual_quantity_in_grams, :decimal
  end
end
