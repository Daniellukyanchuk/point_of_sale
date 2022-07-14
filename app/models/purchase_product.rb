class PurchaseProduct < ApplicationRecord
	belongs_to :purchase
  has_many :inventories
  belongs_to :product, optional: true
  before_save :create_products
  validates :estimated_quantity, :estimated_price_per_unit, presence: true
  validate :product_id_check
  attr_accessor :product_name, :price, :unit, :categories

  def create_products
     if product_id.nil?
      new_product = Product.create(product_name: product_name, price: price, unit: unit, categories: categories, created_at: DateTime.now, updated_at: DateTime.now)
      self.product_id = new_product.id
     end
  end
  
  def product_id_check
    # Check if product_id is blank.
    if product_name.blank? && product_id.blank?
      errors.add(:product_id, "Must choose a product.")
    end
  end

  def set_estimated_subtotal
    self.estimated_subtotal = estimated_quantity * estimated_price_per_unit
  end

  def set_actual_subtotal
  	self.actual_subtotal = actual_quantity * actual_price_per_unit
  end

  def self.clean_orphans
    PurchaseProduct.all.each do |pp|
      if pp.purchase.nil?
        pp.destroy
      end
    end
  end

  def display_text
    if !Inventory.exists?('inventories.purchase_product_id' => id) 
      return "#{purchase_id} - #{purchase.supplier.suppliers_name} - #{purchase.expected_date_of_delivery}" 
    end  
  end
end
