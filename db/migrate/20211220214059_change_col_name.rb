class ChangeColName < ActiveRecord::Migration[5.2]
  def change
    rename_column :inventory_records, :date_received, :date_added
  end
end
