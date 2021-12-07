class Purchase < ApplicationRecord
	has_many :purchase_products
	belongs_to :supplier
	accepts_nested_attributes_for :purchase_products, allow_destroy: true

end
