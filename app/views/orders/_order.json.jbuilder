json.extract! order, :id, :order_id, :client_id, :grand_total, :created_at, :updated_at
json.url order_url(order, format: :json)
