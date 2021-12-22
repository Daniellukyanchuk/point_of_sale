class AddQuantityInGramsToPurchaseProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :purchase_products, :estimated_quantity_in_grams, :decimal
  end
end
