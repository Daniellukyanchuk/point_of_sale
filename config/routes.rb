Rails.application.routes.draw do
  get 'reports/client_report'
  get 'reports/product_report'  
  resources :orders
  resources :products
  resources :clients
  resources :order_products
  resources :client_reports
  resources :product_reports
  
end
