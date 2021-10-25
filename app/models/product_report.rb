class ProductReport < ApplicationRecord
    has_many :orders
    has_many :order_products, through: :orders
    has_many :products, through: :order_products

    def total_revenue
        total_revenue = Product.count(:quanity)
    end

    def units_sold
        units_sold = Product.count(:all)
    end

end
