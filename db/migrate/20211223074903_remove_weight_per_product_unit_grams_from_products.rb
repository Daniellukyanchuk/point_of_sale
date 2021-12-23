class RemoveWeightPerProductUnitGramsFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :weight_per_product_unit_grams, :decimal
  end
end
