Rails.application.routes.draw do

  resources :roles
  post "checkout/create", to: "checkout#create"
  devise_for :users, controllers: { sessions: 'users/sessions' }, path_prefix: "devise"
  post '/api/clients', to: 'api/api_clients#create'
  resources :webhooks, only: [:create]
  patch '/api/clients/:id', to: 'api/api_clients#update'
  get '/api/clients', to: 'api/api_clients#index'

  
  scope "(:locale)", locale: /en|ru/ do 
    get 'clients_imports/new'
    get 'clients_imports/create'
    resources :users
    resources :settings
    resources :productions
    resources :suppliers
    resources :my_models
    
    get '/inventories/current_amount_left', to: 'inventories#get_product_amount_info'
    resources :inventories

    get 'order_report/client_report', to:'order_report#client_report', as: :client_report
    get 'order_report/product_report', to: 'order_report#product_report', as: :product_report
    get 'orders/processing_payment', to: 'orders#processing_payment', as: :proccessing_payment
    resources :orders
   
    get '/tests', to: 'tests#index'
    get '/recipes/grand_total', to: 'recipes#get_recipe_price'
    get '/recipes/product_amount', to: 'recipes#get_product_amount', as: :get_product_amount_info
    resources :recipes
    get '/products/price', to: 'products#get_price'
    resources :products 
    get '/purchases/estimates', to: 'purchases#get_purchase_product_info'
    resources :purchases
    resources :clients 
    resources :clients_imports, only: [:new, :create]
    
    root to: 'orders#index'
  end
end
