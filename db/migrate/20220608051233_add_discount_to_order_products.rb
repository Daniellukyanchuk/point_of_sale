class AddDiscountToOrderProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :order_products, :discount, :decimal
  end
end
