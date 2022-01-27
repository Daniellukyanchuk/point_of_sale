class Production < ApplicationRecord
	belongs_to :recipe
  has_many :inventories
	before_save :set_total
  before_save :set_current_amount_left
    
  def self.search(search, recipe_select, start_date, end_date)
    where_statements = []

    if !search.blank?
      tmp = "(recipes.recipe_name ILIKE '%#{search}%' 
               OR product_id = #{search.to_i} OR product_amount = #{search.to_d} 
               OR grand_total = #{search.to_d} or cost_to_make = #{search.to_d} 
               "
      
      where_statements.push(tmp)
    end

    if !recipe_select.blank?
      ids = []
      recipe_select.each do |ps|
        ids.push(ps.to_i)
      end
      tmp = "recipe_id in (#{SqlHelper.escape_sql_param(ids)})"
      where_statements.push(tmp)
    end

    if !start_date.blank? && !end_date.blank?
      where_statements.push("(CAST(productions.created_at AS DATE) >= #{SqlHelper.escape_sql_param(start_date.to_date)} AND CAST(productions.created_at AS DATE) <= #{SqlHelper.escape_sql_param(end_date.to_date)})")
    end
    where_clause = where_statements.join(" AND ")
    return Production.joins(:recipe).where(where_clause)
  end

  def set_total
    self.grand_total = 0
    self.grand_total = product_amount * recipe_price 
    # production has_many recipes, recipe has_many recipe_products.

    finale = 0
    recipe.recipe_products.each do |rp|
      # cal weighted average for each recipe product
      value_of_item = 0
      sum_of_amount = 0
      Inventory.where("product_id = ? and amount > 0", rp.product_id).each do |inv|
        value_of_item += inv.amount * inv.price_per_unit
        sum_of_amount += inv.amount
      end
      weighted_average = value_of_item / sum_of_amount     
      # cal weighted_average for amount of the ingredient for the product
      ingredient_weighted_average = weighted_average * rp.product_amount
      finale += ingredient_weighted_average * self.product_amount
      
    end
    self.cost_to_make = finale
  end

  def set_current_amount_left   
    change_in_quantity = product_amount - (product_amount_was || 0)

    recipe.recipe_products.each do |rp|        
      Inventory.remove_inventory(rp.product_id, (rp.product_amount || 0) * change_in_quantity)
    end
    Inventory.add_inventory(recipe.product_id, product_amount, recipe_price) 
  end
end