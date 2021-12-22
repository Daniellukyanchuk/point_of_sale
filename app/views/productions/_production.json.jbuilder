json.extract! production, :id, :recipe_id, :recipe_name, :grand_total, :created_at, :updated_at
json.url production_url(production, format: :json)
