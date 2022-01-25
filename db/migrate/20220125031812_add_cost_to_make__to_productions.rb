class AddCostToMakeToProductions < ActiveRecord::Migration[5.2]
  def change
    add_column :productions, :cost_to_make, :decimal
  end
end
