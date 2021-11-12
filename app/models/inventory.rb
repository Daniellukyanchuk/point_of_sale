class Inventory < ApplicationRecord
	belongs_to :product
	before_save :set_costs
	belongs_to :order_product

	def self.search(search)
	  if !search.blank?
	  	return Inventory.joins(:product).where("products.product_name ilike? or product_id = ?", "%#{search.strip}%", search.to_i)
	  else
	  	return Inventory.joins(:product).all
	  end
	end

	def self.product_select(product_select)
	  if !product_select.blank?
	  	return Inventory.joins(:product).where('products.product_name IN (?) OR product_id IN (?)', "%#{product_select}%", product_select)	  	
	  else 
	  	return Inventory.joins(:product).all		
	  end
	end

	

	def current_amount_left
		self.current_amount_left = amount 
	end

	def set_costs
		self.costs = amount * price_per_unit
	end
       
end
