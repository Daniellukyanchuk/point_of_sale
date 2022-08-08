class Product < ApplicationRecord
    has_many :order_products, dependent: :destroy
    has_many :purchase_products
    has_many :recipe_products
    has_many :productions
    has_many :inventories
    has_many :purchases, through: :purchase_products
    has_many :orders, through: :order_products
    has_many :clients, through: :orders
    has_many :suppliers, through: :purchases
    has_many :category_products, dependent: :destroy
    has_many :product_categories, through: :category_products
    accepts_nested_attributes_for :category_products
    validates :product_name, :price, :unit, :grams_per_unit, presence: true
    before_save :assign_product_categories
    validate :check_product_name

  def product_details 
    "#{@raw_products.map{ |c| [c.product_name, c.id,]}} (#{@raw_products.unit})"
  end

  def check_product_name
    if id.blank?
      if Product.exists?(['product_name ILIKE ?', "%#{product_name}%"])
        errors.add(:product_id, "This product name is already in use. Please choose a different name!")
      end
    end
  end

    
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
              SELECT products.id, product_name, ((SUM(purchase_price*remaining_quantity))/(SUM(remaining_quantity)))/(grams_per_unit/1000) AS weighted_price_per_kg,
              (price/(grams_per_unit/1000)) AS price_per_kg
              FROM products
              LEFT OUTER JOIN purchase_products ON products.id = purchase_products.product_id
              LEFT OUTER JOIN inventories ON products.id = inventories.product_id
              WHERE products.id = #{recipe_product_id.to_i}
              GROUP BY products.id, product_name 
          ) report 
          
    """

    return ActiveRecord::Base.connection.execute(sql)
  end


  def assign_product_categories
    category_ids = category_products.ids
    
    category_ids.each do |c_id|
        category_products.push(CategoryProduct.new(product_category_id: c_id))
    end
    
  end

  def update_product_categories(params)   
      
    product_ids = params["category_products_attributes"]["product_id"].values

    #find all existing permissions for this role
    categories_to_clear = CategoryProduct.where("product_id = ?", params[:id].to_i)
    #delete all existing permissions for this role
    CategoryProduct.destroy(categories_to_clear.ids)

    #create role permissions according to new params      
    product_ids.each do |p_id|
      category_products.push(CategoryProduct.new(product_category_id: p_id))
    end
  end

end
