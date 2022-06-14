class AddDiscountPerUnitToOrderProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :order_products, :discount_per_unit, :decimal
  end
end
