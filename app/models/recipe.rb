class Recipe < ApplicationRecord

	has_many :recipe_products, dependent: :destroy
	belongs_to :product
	has_many :productions
	accepts_nested_attributes_for :recipe_products, allow_destroy: true
  validates :yield, presence: true
	
  def self.get_recipe_cost(recipe_id)

      
      sql = """


      SELECT recipe_id, SUM(usage_cost) AS usage_cost, units, yield FROM (
          SELECT recipe_id, 
          (((SUM(purchase_price*remaining_quantity))/(SUM(remaining_quantity)))/(grams_per_unit/1000))*(amount/1000) AS usage_cost
          FROM products
              LEFT OUTER JOIN purchase_products ON products.id = purchase_products.product_id
              LEFT OUTER JOIN inventories ON products.id = inventories.product_id
              LEFT OUTER JOIN recipe_products ON products.id = recipe_products.product_id
          WHERE recipe_id = #{recipe_id.to_i}
          GROUP BY recipe_id, amount, grams_per_unit
          ) report    
      LEFT OUTER JOIN recipes ON recipes.id = recipe_id
      GROUP BY recipe_id, units, yield

            
      """

      return ActiveRecord::Base.connection.execute(sql)      
        
    end

    def self.search(search)
      if !search.blank?
          return Recipe.where("recipe_name ilike ? or unit like ? or id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
      else
      Recipe.all
      end
    end

    
end



