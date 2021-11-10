json.extract! inventory, :id, :product_id, :date, :amount, :price_per_unit, :costs, :current_amount_left, :value_of_item, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
