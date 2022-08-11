class Recipe < ApplicationRecord

	has_many :recipe_products, dependent: :destroy
	belongs_to :product
	has_many :productions
	accepts_nested_attributes_for :recipe_products, allow_destroy: true
  validates :yield, :recipe_name, presence: true
  validates :product_id, presence: { message: "Product Produced can't be blank!"}
	
  def self.get_recipe_cost(recipe_id)

      
      sql = """
        SELECT recipe_id, SUM(usage_cost) AS usage_cost, SUM(default_usage_cost) AS default_usage_cost, units, yield, recipes.product_id FROM (
          SELECT recipe_id, recipes.product_id,
            (((SUM(purchase_price*remaining_quantity))/(SUM(remaining_quantity)))/(grams_per_unit/1000))*(amount/1000) AS usage_cost,
            (price/(grams_per_unit/1000))*(amount/1000) AS default_usage_cost
          FROM products
            LEFT OUTER JOIN purchase_products ON products.id = purchase_products.product_id
            LEFT OUTER JOIN inventories ON products.id = inventories.product_id
            LEFT OUTER JOIN recipe_products ON products.id = recipe_products.product_id
            LEFT OUTER JOIN recipes ON products.id = recipes.product_id
          WHERE recipe_id = #{recipe_id}
          GROUP BY recipe_id, amount, grams_per_unit, recipes.product_id, products.price
          ) report    
      LEFT OUTER JOIN recipes ON recipes.id = recipe_id
      GROUP BY recipe_id, units, yield, recipes.product_id 
            
      """

      return ActiveRecord::Base.connection.execute(sql)      
      stop
    end

    def self.search(search)
      if !search.blank?
        return Recipe.where("recipe_name ilike ? or unit like ? or id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
      else
        Recipe.all
      end
    end


    def self.get_usage_info(recipe_id)

    # if !production.recipe_id.nil?

        sql = """
                SELECT product_name, amount/1000 as usage_amount_kg
                FROM recipe_products
                  LEFT OUTER JOIN products ON products.id = recipe_products.product_id
                WHERE recipe_id = #{SqlHelper.escape_sql_param recipe_id}
              
              """
  
        results = ActiveRecord::Base.connection.execute(sql)  
        end
    # end
    
end



