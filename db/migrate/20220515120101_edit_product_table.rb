class EditProductTable < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :product_code, :string 
    add_column :products, :pv, :integer
    add_column :clients, :registered, :boolean
    add_column :clients, :dob_day, :string
    add_column :clients, :dob_month, :string
    add_column :clients, :dob_year, :string
  end
end