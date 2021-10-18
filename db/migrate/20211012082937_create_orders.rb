class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :order_id
      t.integer :client_id
      t.float :grand_total

      t.timestamps
    end
  end
end
