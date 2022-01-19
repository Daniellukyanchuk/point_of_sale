class Production < ApplicationRecord
	has_many :recipe_products
	belongs_to :recipe	
	# before_save :subtract_used_ingredients

	

	def self.get_recipe_data(recipe_id)

      
      sql = """


      	Select products.id AS product_id, product_name, amount AS amount_in_grams, (remaining_quantity*grams_per_unit) AS remaining_qt_in_grams from inventories 	
			LEFT OUTER JOIN recipe_products ON recipe_products.product_id = inventories.product_id
			LEFT OUTER JOIN products ON products.id = inventories.product_id
		WHERE recipe_id = #{recipe_id.to_i}

             
      """
      return ActiveRecord::Base.connection.execute(sql)      
        
    end

    production_quantity = params["production_quantity"]

    stop

	def subtract_used_ingredients		

			get_recipe_data.each do |ci|

			# amount to remove
			quantity = ci.amount_in_grams * production_quantity

            change_in_quantity = quantity - (quantity_was || 0)

            inventories = Inventory.where("product_id = ? and remaining_quantity > 0", self.product_id).order("created_at asc")
            available_inventory = Inventory.where("product_id = #{self.product_id}").sum(:remaining_quantity)

            amount_left_to_remove = change_in_quantity

            if change_in_quantity < available_inventory
                  
                inventories.each do |sp|
                    
                    #sets remaining amount equalt to remaining amount for the oldest record in the database
                    amount_to_remove = [amount_left_to_remove, sp.remaining_quantity].min
                    #calculates how much needs to be subracted from the next record, if any
                    amount_left_to_remove = amount_left_to_remove - amount_to_remove
                    #subtracts inventory from the current record
                    sp.remaining_quantity = sp.remaining_quantity - amount_to_remove
                    
                    sp.save! #saves result to database
                    
                break if amount_left_to_remove == 0             
            end
               	else alert ("Insuficient Inventory!")
        	end
		end
	end
 end
