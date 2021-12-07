class ChangeSupplyAndSupplyProductTables < ActiveRecord::Migration[5.2]
  
  def change
    change_table "supplies" do |t|
      t.float "estimated_total"
      t.datetime "date_ordered"
      t.datetime "date_expected"
      t.datetime "date_received"
  end

    change_table "supply_products" do |t|
      t.float "estimated_quantity"
      t.float "estimated_cost"
      t.float "estimated_subtotal"
    end
  end
end
