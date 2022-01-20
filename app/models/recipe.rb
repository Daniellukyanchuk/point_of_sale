class Recipe < ApplicationRecord
	belongs_to :product
  has_many :recipe_products, dependent: :delete_all
	accepts_nested_attributes_for :recipe_products, allow_destroy: true
  has_many :productions
  before_save :set_grand_total
  
  def set_grand_total
    self.grand_total = 0
    recipe_products.each do |op|
      op.set_product_subtotals
      self.grand_total = self.grand_total + op.product_subtotal
    end    
  end

  def self.search(search)
    if !search.blank?
      return Recipe.where("recipe_name ilike ? or id = ?", "%#{search.strip}%", search.to_i)    
    else
      Recipe.all
    end
  end
	# before_save :set_grand_total

	
end
