class AddOrderDiscountToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_discount, :decimal
  end
end
