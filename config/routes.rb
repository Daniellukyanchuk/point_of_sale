Rails.application.routes.draw do
  resources :my_models
  resources :inventories
  get 'order_report/client_report'
  get 'order_report/product_report'
  resources :orders

  root to: 'orders#index'
  root to: 'order_products#index'
  resources :products
  resources :clients

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
