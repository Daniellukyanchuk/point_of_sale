Rails.application.routes.draw do
  get '/reports/inventory_report', to: 'reports#inventory_report'
  get '/recipe_products/recipe_info', to: 'products#get_recipe_info'
  get '/recipe/unit', to: 'products#get_unit'
  get '/recipe/production_info', to: 'recipes#get_production_info'
  resources :production_params
  resources :recipes
  resources :recipe_products
  resources :productions
  get '/purchases/product_info', to: 'purchases#get_product_info'
  resources :inventories
  resources :purchases
  resources :purchase_products
  resources :purchase_reports
  resources :inventory_reports
  resources :suppliers
  get 'reports/client_report'
  get 'reports/product_report' 
  get 'reports/purchase_report'
  resources :orders
  get '/products/price', to: 'products#get_price'
  resources :products
  resources :order_products
  resources :product_reports
  resources :clients
  resources :client_reports  
  
  
end


