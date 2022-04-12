class Production < ApplicationRecord
	has_many :recipe_products
	belongs_to :recipe
	validate :recipe_id	
	validate :has_enough_inventory
	after_create :adjust_inventory


	def has_enough_inventory

		#calculates amount of each ingredient needed for the production
		recipe_products.each do |rp|
			amount_needed = rp.amount * production_quantity

		#calculates amount of each ingredient available in the inventory	
		amounts_available = Inventory.get_amounts_for(recipe.recipe_products.map{|rp| rp.product_id})
		amount_available = amounts_available.select {|i| i["product_id"] == rp.product_id }.first["amount_available_in_grams"]
			if amount_needed > amount_available
	    		self.errors.add(:base, "Insufficient #{rp.product.product_name} to produce that amount!")
	    	end
		end
    end

   
	def adjust_inventory

		recipe_products = RecipeProduct.where("recipe_id = ?", recipe_id)		

		recipe_products.each do |ci|
			# quantity to remove
			amount_to_remove = ci.amount * production_quantity
						
			Inventory.remove_used_inventory(ci.product_id, amount_to_remove)
		end
			Inventory.add_inventory(id, self.recipe.product_id, production_yield.to_f, production_total_cost)
	end

	

 end
