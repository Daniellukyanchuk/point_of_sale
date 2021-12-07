class Purchase < ApplicationRecord
	has_many :purchase_products
	belongs_to :supplier
	accepts_nested_attributes_for :purchase_products, allow_destroy: true
	before_save :set_actual_total
	before_save :set_estimated_total

	def set_actual_total
      self.actual_total = 0
      purchase_products.each do |pp|
        pp.set_estimated_subtotal
        self.actual_total = self.actual_total + pp.estimated_subtotal
      end
    end    

    def set_estimated_total
      self.estimated_total = 0
      purchase_products.each do |pp|
    	pp.set_estimated_subtotal
    	self.estimated_total = self.estimated_total + pp.estimated_subtotal
      end
    end
end
