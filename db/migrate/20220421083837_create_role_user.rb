class CreateRoleUser < ActiveRecord::Migration[5.2]
  def change
    create_table :role_users do |t|
      t.integer :user_id
      t.integer :role_id
    end
  end
end
