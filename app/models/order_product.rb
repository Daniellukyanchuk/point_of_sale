class OrderProduct < ApplicationRecord
    belongs_to :order
    has_many :purchase_products
    validates :sale_price, :quantity, presence: true
    after_validation :set_subtotal
    after_destroy :put_back_in_inventory
    
    
        
    def set_subtotal
        self.subtotal = quantity * sale_price
    end
   
    

    def put_back_in_inventory
            # quantity to put back                
            quantity_to_put_back = quantity

            sql =   """
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


    
