class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.integer :supplier_id
      t.date :date_of_the_order
      t.date :expected_date_of_delivery
      t.float :estimated_total
      t.float :actual_total

      t.timestamps
    end
  end
end
