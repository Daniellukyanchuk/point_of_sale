class AddActualQuantityInGramsToPurchaseProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :purchase_products, :actual_quantity_in_grams, :decimal
  end
end
