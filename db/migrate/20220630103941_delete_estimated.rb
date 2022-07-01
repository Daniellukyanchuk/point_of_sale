class DeleteEstimated < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchase_products, :estimated_quantity
    remove_column :purchase_products, :estimated_cost
    remove_column :purchase_products, :estimated_subtotal
    remove_column :purchases, :estimated_total
  end
end
