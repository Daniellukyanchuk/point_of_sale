class Order < ApplicationRecord
    belongs_to :client
    has_many :order_products    
    accepts_nested_attributes_for :order_products, allow_destroy: true
end
