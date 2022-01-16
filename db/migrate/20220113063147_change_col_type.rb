class ChangeColType < ActiveRecord::Migration[5.2]

  change_table :recipes do |t|
    t.integer :product_id
  end
end
