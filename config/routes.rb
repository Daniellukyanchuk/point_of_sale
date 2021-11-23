Rails.application.routes.draw do
  resources :my_models
  resources :inventories
  get 'order_report/client_report'
  get 'order_report/product_report'
  resources :orders

  get '/products/price', to: 'products#get_price'
  resources :products

  resources :clients

  root to: 'orders#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
