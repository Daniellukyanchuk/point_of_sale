class OrderProduct < ApplicationRecord
    belongs_to :order
    belongs_to :products
    belongs_to :clients
end

