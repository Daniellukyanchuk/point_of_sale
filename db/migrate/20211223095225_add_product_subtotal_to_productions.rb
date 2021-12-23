class AddProductSubtotalToProductions < ActiveRecord::Migration[5.2]
  def change
    add_column :productions, :product_subtotal, :decimal
  end
end
