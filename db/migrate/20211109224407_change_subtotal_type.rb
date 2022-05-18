class ChangeSubtotalType < ActiveRecord::Migration[5.2]
  def change
    change_column :order_products, :subtotal, :float
  end
end
