class OrderProduct < ApplicationRecord
    belongs_to :order
    belongs_to :product
    has_many :purchase_products
    has_many :order_product_discounts
    validates :sale_price, :quantity, :product_id, presence: true
    after_validation :apply_client_discount
    after_destroy :put_back_in_inventory

    attr_accessor :item_discount
    
    def apply_client_discount
        
        if !id.blank?
            update_discount
        end
        
        client_discounts = ClientDiscount.where("client_id = ? AND (start_date <= ? OR start_date IS null) AND (end_date >= ? OR end_date IS null) AND discounted_units_left > 0", order.client_id, Date.today, Date.today).order('discount_per_unit DESC') 
        amount_left_to_remove = quantity
        
        if !client_discounts.blank?
            amount_discounted = 0
            client_discounts.each do |d|
                amount_to_remove = [amount_left_to_remove, d.discounted_units_left].min
                amount_discounted += (amount_to_remove * d.discount_per_unit)
                amount_left_to_remove = amount_left_to_remove - amount_to_remove
                d.discounted_units_left = d.discounted_units_left - amount_to_remove
                d.save!
                self.order_product_discounts.push(OrderProductDiscount.new(client_discount_id: d.id, discounted_qt: amount_to_remove))
                break if amount_left_to_remove == 0
            end
            amount_discounted_per_unit = amount_discounted / quantity
            self.sale_price = sale_price - amount_discounted_per_unit
        end
    end

    def self.return_discount(op)
        op.order_product_discounts.each do |rd|
            discount = rd.client_discount 
            discount.discounted_units_left = discount.discounted_units_left + rd.discounted_qt
            discount.save
            rd.delete
        end
    end

    def update_discount
        amount_discounted = 0
        old_order_product = OrderProduct.where("order_id = ? AND id = ?", order.id, id).first
        
        if !old_order_product.order_product_discounts.blank?
            old_order_product.order_product_discounts.each do |rd|
                discount = rd.client_discount
                # puts discounted units back to client_discount
                amount_discounted += rd.discounted_qt * discount.discount_per_unit
                discount.discounted_units_left = discount.discounted_units_left + rd.discounted_qt
                discount.save
                # removes order-product -> client_discount associaton
                rd.delete
            end
        amount_discounted_per_unit = amount_discounted / old_order_product.quantity
        self.sale_price = old_order_product.sale_price + amount_discounted_per_unit
        end      
    end

    def set_subtotal        
        self.sale_price = (sale_price - item_discount.to_i)
        self.subtotal = (quantity * sale_price)
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
        
        if !result.first.blank?
            cost_per_unit = result.first["weighted_cpu"]        

            Inventory.return_inventory(product_id, order_id, quantity_to_put_back, cost_per_unit)            
            end
        end
    end


    
