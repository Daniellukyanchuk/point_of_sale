class AddLaborCost < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :labor_cost, :Integer
    add_column :productions, :employee_id, :integer
  end
end
