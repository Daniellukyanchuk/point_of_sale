class AddClientFields < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :last_name, :string
    add_column :clients, :middle_name, :string
    add_column :clients, :gender, :string
    add_column :clients, :date_of_birth, :date
    add_column :clients, :zip_code, :string
    add_column :clients, :email, :string  
    add_column :clients, :contact_method, :string  
  end
end
