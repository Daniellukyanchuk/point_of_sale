class Order < ApplicationRecord
    has_many :order_products
    belongs_to :client    
    accepts_nested_attributes_for :order_products, allow_destroy: true
    before_save :set_grand_total
    
    def set_grand_total

        grand_total = 0 
        
        order_products.each do |op|
            op.set_subtotal
            
            grand_total = op.subtotal
        end    

    
    end
    
        

end
