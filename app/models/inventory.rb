

class Inventory < ApplicationRecord
	belongs_to :purchase_product
    belongs_to :product
    belongs_to :purchase
	before_create :set_remaining_quantity

    attr_accessor :purchase_quantity

	   def set_remaining_quantity

            if self.purchase_quantity.blank?
                self.remaining_quantity = nil
            else
                self.remaining_quantity = purchase_quantity
            end
        end

    def self.search(search)
      if !search.blank?
          return Inventory.where("id = ? or product_id = ? or purchase_order_id = ? or purchase_order_product_id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
      else
      Inventory.all
      end
    end

end
