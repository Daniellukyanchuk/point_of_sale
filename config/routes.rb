Rails.application.routes.draw do
  resources :orders
  resources :products
  resources :clients
  resources :order_products

end
