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


    # def adjust_inventory

    #         change_in_quantity = self.quantity - (self.quantity_was || 0)

    #         inventories = Inventory.where("product_id = ? and remaining_quantity > 0", self.product_id).order("created_at asc")
    #         available_inventory = Inventory.where("product_id = #{self.product_id}").sum(:remaining_quantity)

    #         amount_left_to_remove = change_in_quantity

    #         if change_in_quantity < available_inventory
                  
    #             inventories.each do |sp|
                    
    #                 #sets remaining amount equalt to remaining amount for the oldest record in the database
    #                 amount_to_remove = [amount_left_to_remove, sp.remaining_quantity].min
    #                 #calculates how much needs to be subracted from the next record, if any
    #                 amount_left_to_remove = amount_left_to_remove - amount_to_remove
    #                 #subtracts inventory from the current record
    #                 sp.remaining_quantity = sp.remaining_quantity - amount_to_remove
                    
    #                 sp.save! #saves result to database
                    
    #                 break if amount_left_to_remove == 0             
    #             end 
    #         else alert ("Insuficient Inventory!")
    #     end

    # end        

