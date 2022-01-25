class Production < ApplicationRecord
	belongs_to :recipe
  has_many :inventories
	before_save :set_total
  before_save :set_current_amount_left
    
  def self.search(search)
    if !search.blank?
      return Production.where("recipe_id = ? or id = ?", search.to_i, search.to_i)    
    else
      Production.all
    end
  end


  # To find a weighted average, multiply each number by its weight, then add the results. 
  # If the weights don't add up to one, find the sum of all the variables multiplied by their weight, 
  # then divide by the sum of the weights.
  def set_total
    self.grand_total = 0
    self.grand_total = product_amount * recipe_price 
    #production has_many recipes, recipe has_many ingredients.



    self.cost_to_make = 0
    cs, qu = 0.0, 0.0
    a = Inventory.where("product_id = ? and amount > 0", recipe_id).sum(&:amount)
    b = Inventory.where("product_id = ? and price_per_unit > 0", recipe_id).sum(&:price_per_unit)
    ppt = RecipeProduct.where("recipe_id = ? and product_price > 0", recipe_id)
    cs += a * b
    qu += a 
   
    self.cost_to_make = cs / qu 
  end

  def set_current_amount_left   
    change_in_quantity = product_amount - (product_amount_was || 0)

    recipe.recipe_products.each do |rp|        
      Inventory.remove_inventory(rp.product_id, (rp.product_amount || 0) * change_in_quantity)
    end
    
    Inventory.add_inventory(recipe.product_id, product_amount, recipe_price) 
  end
end

    # cs, qu = 0.0, 0.0
    # a = Inventory.where("product_id = ? and amount > 0", product_id).sum(&:amount)
    # ppt = Inventory.where("product_id = ? and price_per_unit > 0", product_id).sum(&:price_per_unit)
    # cs += a * ppt
    # qu += ppt 
    # stop 
    # self.cost_to_make = cs / qu 