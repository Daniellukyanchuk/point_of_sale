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

    def set_current_amount_left   
      # make a variable change_in_quantity and set it equal to self.quantity.
      change_in_quantity = product_amount - (product_amount_was || 0)

      recipe.recipe_products.each do |rp|
        
        Inventory.remove_inventory(rp.product_id, rp.product_amount * change_in_quantity)

      end

      Inventory.add_inventory(what_product_id, what_amount)
        
    end
end
