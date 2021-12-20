json.extract! inventory_record, :id, :created_at, :updated_at
json.url inventory_record_url(inventory_record, format: :json)
