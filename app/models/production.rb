class Production < ApplicationRecord
	belongs_to :recipe
	before_save :set_total
  before_save :set_current_amount_left
    
  def self.search(search)
    if !search.blank?
      return Production.where("recipe_id = ? or id = ?", search.to_i, search.to_i)    
    else
      Production.all
    end
  end

  def set_total
    self.grand_total = 0
    self.grand_total = product_amount * recipe_price 
  end

  def is_done?
  end 

  # def has_enough_inventory
  #   total_inv = Inventory.where("product_id = ? and current_amount_left > 0", product_id).sum(&:current_amount_left)
    
  #   if total_inv < self.product_amount
  #     errors.add(:product_amount, "Not enough inventory for this product")
  #   end
  # end

  def set_current_amount_left   
    change_in_quantity = product_amount - (product_amount_was || 0)

    recipe.recipe_products.each do |rp|        
      Inventory.remove_inventory(rp.product_id, (rp.product_amount || 0) * change_in_quantity)
    end
    
    Inventory.add_inventory(recipe_id, product_amount, recipe_price, created_at) 
  end
end
