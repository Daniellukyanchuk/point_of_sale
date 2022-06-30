class CreateClientDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :client_discounts do |t|
      t.string :discount_name
      t.integer :client_id
      t.float :discount_per_unit
      t.integer :discounted_units
      t.integer :discounted_units_left
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
