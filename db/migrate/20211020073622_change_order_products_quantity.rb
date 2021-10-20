class ChangeOrderProductsQuantity < ActiveRecord::Migration[5.2]
  def change
    change_column :order_products, :quantity, :integer
  end

  def change
    change_column :order_products, :sales_price, :integer
  end

  def change
    change_column :order_products, :subtotal, :integer
  end

end
