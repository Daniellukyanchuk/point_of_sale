Rails.application.routes.draw do
  resources :suppliers
  resources :my_models
  resources :inventories
  get 'order_report/client_report'
  get 'order_report/product_report'
  resources :orders

  get '/tests', to: 'tests#index'
  get '/products/price', to: 'products#get_price'
  resources :products

  get '/purchases/estimated_quantity', to: 'purchases#get_estimated_quantity'
  get '/purchases/estimated_price_per_unit', to: 'purchases#get_estimated_price_per_unit'
  get '/purchases/estimated_subtotal', to: 'purchases#get_estimated_subtotal'
  resources :purchases
  resources :clients
  root to: 'orders#index'
  root to: 'purchases#index'
  root to: 'products#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
