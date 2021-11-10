class Inventory < ApplicationRecord
	belongs_to :product

	def self.search(search)
	  if !search.blank?
	  	return Inventory.joins(:product).where("products.product_name ilike? or product_id = ?", "%#{search.strip}%", search.to_i)
	  else
	  	return Inventory.joins(:product).all
	  end
	end


       
end
