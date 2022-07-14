Rails.application.routes.draw do
  post "checkout/create", to: "checkout#create"
  devise_for :users, controllers: { sessions: 'users/sessions' }, path_prefix: "devise"
  post '/api/clients', to: 'api/api_clients#create'
  resources :webhooks, only: [:create]
  patch '/api/clients/:id', to: 'api/api_clients#update'
  get '/api/clients', to: 'api/api_clients#index'
  
  scope "(:locale)", locale: /en|ru/ do 
    get '/application/exchange', to: 'application#get_exchange_rate'
    get 'clients_imports/new'
    get 'clients_imports/create'
    get 'roles/export', to: 'roles#export_roles', as: :role_export
    resources :roles_imports, only: [:new, :create]
    resources :roles
    resources :users
    resources :settings
    resources :productions
    resources :suppliers
    resources :my_models
    get '/inventories/current_amount_left', to: 'inventories#get_product_amount_info', as: :current_amount_left
    resources :inventories
    get 'order_report/client_report', to:'order_report#client_report', as: :client_report
    get 'order_report/product_report', to: 'order_report#product_report', as: :product_report
    get 'orders/:id/order_invoice', to: 'orders#order_invoice', as: :order_invoice
    get 'orders/bulk_invoice', to: 'orders#bulk_invoice', as: :bulk_invoice
    resources :orders
    get '/tests', to: 'tests#index'
    get '/recipes/grand_total', to: 'recipes#get_recipe_price'
    get '/recipes/product_amount', to: 'recipes#get_product_amount', as: :get_product_amount_info
    resources :recipes
    get '/products/price', to: 'products#get_price'
    resources :products 
    get '/purchases/actuals', to: 'purchases#get_purchase_product_info'
    resources :order_product_discounts
    get '/discounts/discount_per_kilo', to: 'discounts#get_client_discount'
    resources :discounts
    resources :purchases
    resources :clients 
    resources :clients_imports, only: [:new, :create]
    root to: 'orders#index'
  end
end
