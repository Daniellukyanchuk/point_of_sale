class Product < ApplicationRecord
  has_many :order_products
  has_many :orders, through: :order_products
  has_many :clients, through: :orders
  has_many :inventories  
  has_many :purchase_products
  has_many :recipe_products

  def self.search(search)
    if !search.blank?
      return Product.where("product_name ilike ? or id = ?", "%#{search.strip}%", search.to_i)    
    else
      Product.all
    end
  end
end