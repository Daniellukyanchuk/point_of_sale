class OrderProduct < ApplicationRecord
    belongs_to :order
    belongs_to :product
    has_many :purchase_products
    validates :sale_price, :quantity, :product_id, presence: true
    before_save :set_subtotal
    after_destroy :put_back_in_inventory

    attr_accessor :item_discount
    
        
    def set_subtotal
        self.sale_price = sale_price - item_discount.to_i
        self.subtotal = quantity * sale_price
    end    


    def put_back_in_inventory
        # quantity to put back                
        quantity_to_put_back = quantity

        sql =   
            """
            SELECT product_id,
                (CASE 
                    WHEN 
                        SUM(remaining_quantity) > 0
                    THEN
                        SUM(cost_per_unit*remaining_quantity)/(SUM(remaining_quantity)) 
                    ELSE
                        0
                END) AS weighted_cpu
            FROM inventories
            WHERE product_id = #{product_id.to_i} 
            GROUP BY product_id

            """

        result = ActiveRecord::Base.connection.execute(sql)
        
        cost_per_unit = result.first["weighted_cpu"]        

        Inventory.return_inventory(product_id, order_id, quantity_to_put_back, cost_per_unit)            
        end
    end


    
