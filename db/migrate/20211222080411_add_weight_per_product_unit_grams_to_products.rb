class AddWeightPerProductUnitGramsToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :weight_per_product_unit_grams, :decimal
  end
end
