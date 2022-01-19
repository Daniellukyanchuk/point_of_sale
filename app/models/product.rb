class Product < ApplicationRecord
    has_many :order_products, dependent: :destroy
    has_many :purchase_products
    has_many :recipe_products
    has_one :recipe
    has_many :inventories
    has_many :purchases, through: :purchase_products
    has_many :orders, through: :order_products
    has_many :clients, through: :orders
    has_many :suppliers, through: :purchases
    validates :product_name, :price, :unit, :grams_per_unit, presence: true

   

  def self.search(search)
      if !search.blank?
          return Product.where("product_name ilike ? or unit like ? or id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
      else
      Product.all
      end
    end

    def self.get_price_per_kg(recipe_product_id)

      
      sql = """
            SELECT * FROM (
                SELECT products.id, product_name, ((SUM(purchase_price*remaining_quantity))/(SUM(remaining_quantity)))/(grams_per_unit/1000) AS weighted_price_per_kg
                FROM products
                LEFT OUTER JOIN purchase_products ON products.id = purchase_products.product_id
                LEFT OUTER JOIN inventories ON products.id = inventories.product_id
                WHERE products.id = #{recipe_product_id.to_i}
                GROUP BY products.id, product_name 
            ) report 

            
      """

      return ActiveRecord::Base.connection.execute(sql)      
        
    end


end
