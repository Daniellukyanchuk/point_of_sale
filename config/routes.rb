Rails.application.routes.draw do
  get 'reports/clients_report'
  get 'reports/products_report'
  
  resources :orders
  resources :products
  resources :clients
  resources :order_products
  resources :product_reports

end
