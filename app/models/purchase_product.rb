class PurchaseProduct < ApplicationRecord
	belongs_to :purchase
  has_many :inventories
  belongs_to :product



  def set_estimated_subtotal
    self.estimated_subtotal = estimated_quantity * estimated_price_per_unit
  end

  def set_actual_subtotal
  	self.actual_subtotal = actual_quantity * actual_price_per_unit
  end

  def set_grams_per_unit
    self.estimated_quantity_in_grams = estimated_quantity * Product.unit_in_grams
  end

  def self.clean_orphans
    PurchaseProduct.all.each do |pp|
      if pp.purchase.nil?
        pp.destroy
      end
    end
  end

  def display_text
    return "#{purchase_id} - #{product.product_name} - #{purchase.supplier.suppliers_name} - #{purchase.expected_date_of_delivery}"
  end
end
