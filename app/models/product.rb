class Product < ApplicationRecord
    has_many :order_products
    has_many :supply_products
    has_many :supplies, through: :supply_products
    has_many :orders, through: :order_products
    has_many :clients, through: :orders
    has_many :suppliers, through: :supplies

    def self.product(sortable, sort_direction)

        sql = """
                SELECT product_name,
                    SUM(quantity)::numeric(10,2) AS units_sold,
                    SUM(purchase_quantity)::numeric(10,2) AS units_purchased,
                    ((SUM(purchase_quantity))-(SUM(quantity)))::numeric(10,2) AS inventory
                FROM products 
                    INNER JOIN order_products 
                    ON products.id = order_products.product_id
                    INNER JOIN supply_products 
                    ON products.id = supply_products.product_id
                GROUP BY product_name
            """
            result = ActiveRecord::Base.connection.execute(sql)

            if !["id", "product_name", "units_sold", "units_purchased", "units_sold", "inventory"].include?(sortable)
              sortable = "product_name"
            end
            
            if  sort_direction == "desc"
              "desc"
            else
              sort_direction = "asc"
            end
      end
  
      
    def self.search(search)
      if !search.blank?
          return Product.where("product_name ilike ? or unit like ? or id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
      else
      Product.all
      end
    end

end
