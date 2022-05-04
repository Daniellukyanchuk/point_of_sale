json.extract! product_category, :id, :category_name, :category_description, :created_at, :updated_at
json.url product_category_url(product_category, format: :json)
