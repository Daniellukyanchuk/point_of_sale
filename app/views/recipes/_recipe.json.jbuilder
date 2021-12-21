json.extract! recipe, :id, :recipe_product_id, :recipe_name, :cooking_instructions, :grand_total, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
