class CreatePermission < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.string :table
      t.string :action
    end
  end
end
