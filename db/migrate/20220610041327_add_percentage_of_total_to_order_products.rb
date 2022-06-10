class AddPercentageOfTotalToOrderProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :order_products, :percentage_of_total, :decimal
  end
end
