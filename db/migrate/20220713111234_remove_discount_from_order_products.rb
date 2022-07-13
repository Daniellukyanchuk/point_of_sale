class RemoveDiscountFromOrderProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :order_products, :discount, :decimal
  end
end
