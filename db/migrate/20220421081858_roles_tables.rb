class RolesTables < ActiveRecord::Migration[5.2]
  def change
    create_table :role_users do |t|
      t.integer :user_id
      t.integer :role_id

      t.timestamps
    end

    create_table :role_permissions do |t|
      t.integer :role_id
      t.integer :permission_id

      t.timestamps
    end

    create_table :permissions do |t|
      t.string :table
      t.string :action

      t.timestamps
    end
  end
end
