class Supplier < ApplicationRecord
	has_many :purchases
	has_many :products, through: :purchase_products
	has_many :purchase_products, through: :purchases
end
