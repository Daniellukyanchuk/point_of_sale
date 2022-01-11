class Product < ApplicationRecord
    has_many :order_products, dependent: :destroy
    has_many :purchase_products
    has_many :inventories
    has_many :purchases, through: :purchase_products
    has_many :orders, through: :order_products
    has_many :clients, through: :orders
    has_many :suppliers, through: :purchases

   

  def self.search(search)
      if !search.blank?
          return Product.where("product_name ilike ? or unit like ? or id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
      else
      Product.all
      end
    end

end
