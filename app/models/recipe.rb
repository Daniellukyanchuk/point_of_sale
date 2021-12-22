class Recipe < ApplicationRecord
	has_many :recipe_products, dependent: :delete_all
	accepts_nested_attributes_for :recipe_products, allow_destroy: true
	before_save :set_grand_total

	def set_grand_total
      self.grand_total = 0
      recipe_products.each do |op|
        op.set_product_subtotal
        self.grand_total = self.grand_total + op.product_subtotal
      end    
    end
end
