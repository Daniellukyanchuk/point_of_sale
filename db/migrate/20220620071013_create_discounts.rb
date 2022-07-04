class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.integer :client_id
      t.decimal :discount_per_kilo
      t.decimal :expiration_amount
      t.date :starting_date
      t.date :ending_date

      t.timestamps
    end
  end
end
