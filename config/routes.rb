Rails.application.routes.draw do
  
  get 'clients_imports/new'
  get 'clients_imports/create'
  scope "(:locale)", locale: /en|ru/ do 
  
    resources :productions
    resources :suppliers
    resources :my_models
    resources :inventories
    get 'order_report/client_report', to:'order_report#client_report', as: :client_report
    get 'order_report/product_report', to: 'order_report#product_report', as: :product_report
    resources :orders

    
    get '/tests', to: 'tests#index'
    get '/products/price', to: 'products#get_price'
    get '/recipes/grand_total', to: 'recipes#get_recipe_price'
    resources :recipes
    resources :products 
    get '/purchases/estimates', to: 'purchases#get_purchase_product_info'
    resources :purchases

    resources :clients 
    resources :clients_imports, only: [:new, :create]

    root to: 'clients#index'

    root to: 'orders#index'
    root to: 'purchases#index'
    root to: 'products#index'

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
