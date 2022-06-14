class AddHowMuchDiscountToApplyToOrderProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :order_products, :discount_to_apply, :decimal
  end
end
