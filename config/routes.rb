Rails.application.routes.draw do
  resources :productions
  resources :suppliers
  resources :my_models
  resources :inventories
  get 'order_report/client_report'
  get 'order_report/product_report'
  resources :orders
  
  scope "(:locale)", locale: /end|ru|ky/ do 
  end
  get '/tests', to: 'tests#index'
  get '/products/price', to: 'products#get_price'
  get '/recipes/grand_total', to: 'recipes#get_recipe_price'
  resources :recipes
  resources :products
  get '/purchases/estimates', to: 'purchases#get_purchase_product_info'
  resources :purchases
  resources :clients
  root to: 'orders#index'
  root to: 'purchases#index'
  root to: 'products#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
