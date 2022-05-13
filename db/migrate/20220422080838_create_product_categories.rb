class CreateProductCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :product_categories do |t|
      t.string :category_name
      t.text :category_description

      t.timestamps
    end

    create_table :category_products do |t|
      t.belongs_to :product_category
      t.belongs_to :product

      t.timestamps
    end
  end
end
