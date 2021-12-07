json.extract! supplier, :id, :suppliers_name, :city, :country, :address, :supply_product_id, :phone_number, :created_at, :updated_at
json.url supplier_url(supplier, format: :json)
