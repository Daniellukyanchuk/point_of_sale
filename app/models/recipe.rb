class Recipe < ApplicationRecord

	has_many :recipe_products, dependent: :destroy
	belongs_to :product
	has_many :productions
	accepts_nested_attributes_for :recipe_products, allow_destroy: true
	



    def self.search(search)
      if !search.blank?
          return Recipe.where("recipe_name ilike ? or unit like ? or id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
      else
      Recipe.all
      end
    end

    
end



