class InventoryRecord < ApplicationRecord
	has_many :supply_products
	before_create :set_remaining_quantity

    attr_accessor :purchase_quantity

	 def set_remaining_quantity

        if self.purchase_quantity.blank?
            self.remaining_quantity = nil
        else
            self.remaining_quantity = purchase_quantity
        end
    end
end
