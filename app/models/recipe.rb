class Recipe < ApplicationRecord
	has_many :recipe_products, dependent: :destroy
	has_many :products
	has_many :productions
	accepts_nested_attributes_for :recipe_products, allow_destroy: true
	before_save :set_recipe_total



	def set_recipe_total

        self.recipe_total = 0
        #loop to add up subtotals into recipe total
        purchase_products.each do |r|
          r.set_ingredient_total
          self.recipe_total = self.recipe_total + r.ingredient_total
        end  
    end

    def self.search(search)
      if !search.blank?
          return Recipe.where("recipe_name ilike ? or unit like ? or id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
      else
      Recipe.all
      end
    end

    
end



