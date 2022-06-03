class Purchase < ApplicationRecord
  # dependent: :delete_all allows me to delete orphans that purchase_products would have if I deleted purchase.
 	has_many :purchase_products, dependent: :delete_all
	belongs_to :supplier, optional: true
	accepts_nested_attributes_for :purchase_products, allow_destroy: true
	before_save :set_actual_total
	before_save :set_estimated_total
  before_save :create_suppliers
  attr_accessor :suppliers_name, :city, :country, :address, :phone_number

  def create_suppliers
    if supplier_id.nil?
      new_supplier = Supplier.create(suppliers_name: suppliers_name, city: city, country: country, address: address, phone_number: phone_number)
      self.supplier_id = new_supplier.id
    end
  end
  
	def self.search(search, supplier_select, start_date, end_date)
    where_statements = []

    if !search.blank?
      tmp = "(suppliers_name ILIKE '%#{search}%' 
               OR supplier_id = #{search.to_i} OR estimated_total = #{search.to_d} 
               OR actual_total = #{search.to_d})"
      
      where_statements.push(tmp)
    end

    if !supplier_select.blank?
      ids = []
      supplier_select.each do |ps|
        ids.push(ps.to_i)
      end
      tmp = "supplier_id in (#{SqlHelper.escape_sql_param(ids)})"
      where_statements.push(tmp)
    end
    
    if !start_date.blank? && !end_date.blank?
      where_statements.push("(CAST(purchases.created_at AS DATE) >= #{SqlHelper.escape_sql_param(start_date.to_date)} 
                              AND CAST(purchases.created_at AS DATE) <= #{SqlHelper.escape_sql_param(end_date.to_date)})")
    end
    where_clause = where_statements.join(" AND ")
    return Purchase.joins(:supplier).where(where_clause)
  end

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
