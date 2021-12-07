class CreateSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :suppliers do |t|
      t.string :suppliers_name
      t.string :city
      t.string :country
      t.string :address
      t.integer :supply_product_id
      t.bigint :phone_number

      t.timestamps
    end

    # change_table :clients do |t|
    #   t.string :associate_phone_number
    # end
  end
end
