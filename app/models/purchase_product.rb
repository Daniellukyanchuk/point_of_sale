class PurchaseProduct < ApplicationRecord
	belongs_to :purchase
  belongs_to :inventory

  def set_estimated_subtotal
    self.estimated_subtotal = estimated_quantity * estimated_price_per_unit
  end

  def set_actual_subtotal
  	self.actual_subtotal = actual_quantity * actual_price_per_unit
  end
end