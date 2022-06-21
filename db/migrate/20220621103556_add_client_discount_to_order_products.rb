class AddClientDiscountToOrderProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :order_products, :client_discount, :decimal
  end
end
