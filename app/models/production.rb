class Production < ApplicationRecord
	belongs_to :recipe
	before_save :set_total
    
    def self.search(search)
      if !search.blank?
        return Production.where("recipe_id = ? or id = ?", search.to_i, search.to_i)    
      else
        Production.all
      end
    end

    def set_total
      # self.grand_total = 0
      self.grand_total = product_amount * recipe_price 
    end

    def set_current_amount_left   
    
      # amount_left_to_remove should always be the amount of inventory that we still have to remove
      # make a variable change_in_quantity and set it equal to self.quatity.
      change_in_quantity = self.quantity - (self.quantity_was || 0)
      # make a variable amount_left_to_remove and set it equal to change_in_quantity.
    
      Inventory.remove_inventory(self.product_id, change_in_quantity)    
    end
end
