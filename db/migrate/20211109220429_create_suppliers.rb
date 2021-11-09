class CreateSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :suppliers do |t|
      t.string :supplier_name
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
