class ChangeSupplyProductsDataType < ActiveRecord::Migration[5.2]
  def change
    change_column :supplies, :date_ordered, 'date USING CAST(date_ordered AS date)'
    change_column :supplies, :date_expected, 'date USING CAST(date_expected AS date)'
    change_column :supplies, :date_received, 'date USING CAST(date_received AS date)'
    
  end
end
