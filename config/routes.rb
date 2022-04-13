Rails.application.routes.draw do
 
  
  
  scope "/:locale" do
    resources :settings
    resources :products_imports, only: [:new, :create]
    get '/recipe_products/recipe_info', to: 'products#get_recipe_info', as: :products_get_recipe_info
    get '/recipe/unit', to: 'products#get_unit', as: :products_get_unit
    get '/recipe/production_info', to: 'recipes#get_production_info', as: :recipes_get_production_info
    get '/recipe/usage_info', to: 'recipes#get_usage_info', as: :recipes_get_usage_info
    resources :usage_info
    resources :production_params
    resources :recipes
    resources :recipe_products
    resources :productions
    get '/purchases/product_info', to: 'purchases#get_product_info', as: :purchases_get_product_info
    resources :purchases
    resources :purchase_products
    resources :purchase_reports
    resources :suppliers
    get 'reports/client_report'
    get 'reports/product_report' 
    get 'reports/purchase_report'
    get '/reports/inventory_report'
    resources :inventories
    resources :inventory_summaries
    resources :orders
    get '/products/price', to: 'products#get_price', as: :products_get_price
    resources :products     
    resources :order_products
    resources :product_reports
    resources :clients
    resources :client_reports
  end
end


