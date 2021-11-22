class OrderProduct < ApplicationRecord
    belongs_to :order
    has_many :supply_products
    validates :sale_price, :quantity, presence: true
    after_validation :set_subtotal
    before_save :adjust_inventory
    after_save :on_after_save
    after_save :set_remaining_quantity
    
        
    def set_subtotal
        self.subtotal = quantity * sale_price
    end
   

    def adjust_inventory

    product_id = order["order_products_attributes"]["0"]["product_id"]

        sql = """
              SELECT id AS purchase_id, product_id, purchase_subtotal, purchase_quantity, remaining_quantity, created_at 
              FROM supply_products
              WHERE product_id = #{product_id} AND remaining_quantity > 0
              ORDER BY created_at asc
              """
              result = ActiveRecord::Base.connection.execute(sql)
    end

    def set_remaining_quantity

        # altr = amount left to remove (overall)
        # rem_a = remaining amount (in current inventory record)
        # atr = amount to remove (from current inventory record)

        quantity = order["order_products_attributes"]["0"]["quantity"]

        altr = quantity.to_i
        
        adjust_inventory.each do |ai|
            rem_a = remaining_quantity
            atr = [altr, rem_a].min
            altr = altr - atr
            rem_a = rem_a - atr            
            remaining_quantity = rem_a
            remaining_quantity.save
            break if altr == 0
        end

    end        

    def on_after_save
        delta = quantity - (quantity_was || 0)
    end

end

