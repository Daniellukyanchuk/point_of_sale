class Supplier < ApplicationRecord
	has_many :purchases
	has_many :products, through: :purchase_products
	has_many :purchase_products

	def self.search(search)
      if !search.blank?
        return Supplier.where("suppliers_name ilike ? or id = ?", "%#{search.strip}%", search.to_i)    
      else
        Supplier.all
      end
    end
end
