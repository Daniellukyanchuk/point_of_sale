class AddRecipePriceToProductions < ActiveRecord::Migration[5.2]
  def change
    add_column :productions, :recipe_price, :decimal
  end
end
