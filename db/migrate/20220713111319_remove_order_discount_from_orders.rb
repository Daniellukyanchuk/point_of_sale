class RemoveOrderDiscountFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :order_discount, :decimal
  end
end
