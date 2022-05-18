class CreateSupplies < ActiveRecord::Migration[5.2]
  def change
    create_table "supplies", force: :cascade  do |t|
      t.integer "supplier_id"
      t.float "purchase_total"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
