Rails.application.routes.draw do
  get 'purchasing_report/product_name', to: 'supplies#get_product_name'
  get 'purchasing_report/actual_quantity', to: 'supplies#get_qt'
  get 'purchasing_report/supplier_name', to: 'supplies#get_supplier'
  resources :inventory_records
  resources :supplies
  resources :supply_products
  resources :purchase_reports
  resources :suppliers
  get 'reports/client_report'
  get 'reports/product_report' 
  get 'reports/purchase_report'
  resources :orders
  get 'products/price', to: 'products#get_price'
  resources :products
  resources :order_products
  resources :product_reports
  resources :clients
  resources :client_reports  
  
  
end


