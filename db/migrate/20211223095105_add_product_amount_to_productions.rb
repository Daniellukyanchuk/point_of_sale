class AddProductAmountToProductions < ActiveRecord::Migration[5.2]
  def change
    add_column :productions, :product_amount, :decimal
  end
end
