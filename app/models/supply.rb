class Supply < ApplicationRecord
    has_many :supply_products
    has_many :product_reports
    belongs_to :supplier  
    accepts_nested_attributes_for :supply_products, allow_destroy: true
    before_save :set_purchase_total


    def set_purchase_total

        self.purchase_total = 0
        #loop to add up subtotals into purchase total
        supply_products.each do |sp|
          sp.set_purchase_subtotal
          self.purchase_total = self.purchase_total + sp.purchase_subtotal
        end  
    end

    

end
