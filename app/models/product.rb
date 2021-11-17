class Product < ApplicationRecord
    has_many :order_products
    has_many :supply_products
    has_many :supplies, through: :supply_products
    has_many :orders, through: :order_products
    has_many :clients, through: :orders
    has_many :suppliers, through: :supplies

    def self.product_inventory(sortable, sort_direction)
      
        sql = """
                SELECT * FROM (
                SELECT products.id, product_name, unit, price,
                    SUM(quantity)::numeric(10,2) AS units_sold,
                    SUM(purchase_quantity)::numeric(10,2) AS units_purchased,
                    ((SUM(purchase_quantity))-(SUM(quantity)))::numeric(10,2) AS inventory
                FROM products 
                    LEFT OUTER JOIN order_products 
                    ON products.id = order_products.product_id
                    LEFT OUTER JOIN supply_products 
                    ON products.id = supply_products.product_id
                GROUP BY products.id, product_name, products.unit, products.price
                ) report
                ORDER BY #{sortable} #{sort_direction}
            """
            result = ActiveRecord::Base.connection.execute(sql)

        

            if !["products.id", "product_name", "price", "units_sold", "units_purchased", "units_sold", "inventory"].include?(sortable)
              sortable = "price"
            end
            
            if  sort_direction == "desc"
              "desc"
            else
              sort_direction = "asc"
            end

            return result
            
      end
  
      
    def self.search(search)
      if !search.blank?
          return Product.where("product_name ilike ? or unit like ? or id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
      else
      Product.all
      end
    end

end
