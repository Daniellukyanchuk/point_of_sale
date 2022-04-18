class ChangeColType < ActiveRecord::Migration[5.2]

  change_column :recipes, :product_id, :integer
end
