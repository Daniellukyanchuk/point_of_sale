class EditProductTable < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :product_code, :string 
    add_column :products, :pv, :integer  
  end
end
