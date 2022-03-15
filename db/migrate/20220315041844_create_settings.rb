class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.string :company_name
      t.string :company_address
      t.string :country
      t.string :city

      t.timestamps
    end
  end
end
