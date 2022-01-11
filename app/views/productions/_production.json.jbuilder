json.extract! production, :id, :recipe_name, :production_quantity, :production_total_cost, :created_at, :updated_at
json.url production_url(production, format: :json)
