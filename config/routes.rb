Rails.application.routes.draw do
  resources :supplies
  resources :suppliers
  resources :supply_products
  get 'reports/client_report'
  get 'reports/product_report' 
  resources :orders
  get 'products/price', to: 'products#get_price'
  resources :products
  resources :clients
  resources :order_products
  resources :client_reports
  resources :product_reports
  resources :product_inventories
  
end
