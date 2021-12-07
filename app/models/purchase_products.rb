class PurchaseProduct < ApplicationRecord
	belongs_to :purchase

  def set_estimated_subtotal
    self.estimated_subtotal = estimated_quantity * estimated_price_per_unit
  end
end