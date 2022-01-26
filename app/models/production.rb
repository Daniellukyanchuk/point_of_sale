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