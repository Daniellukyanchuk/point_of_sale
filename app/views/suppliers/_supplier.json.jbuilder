json.extract! supplier, :id, :supplier_name, :address, :phone, :created_at, :updated_at
json.url supplier_url(supplier, format: :json)
