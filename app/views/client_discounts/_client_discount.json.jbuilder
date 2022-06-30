json.extract! client_discount, :id, :discount_name, :client_id, :discount_per_unit, :discounted_units, :discounted_units_left, :start_date, :end_date, :created_at, :updated_at
json.url client_discount_url(client_discount, format: :json)
