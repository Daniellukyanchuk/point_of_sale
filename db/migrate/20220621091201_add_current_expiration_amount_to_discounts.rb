class AddCurrentExpirationAmountToDiscounts < ActiveRecord::Migration[5.2]
  def change
    add_column :discounts, :current_expiration_amount, :decimal
  end
end
