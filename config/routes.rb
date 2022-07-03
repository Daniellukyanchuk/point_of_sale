Rails.application.routes.draw do  
  
  root to: "products#index"
  
  scope "/:locale" do      
    devise_for :users, controllers: { sessions: "users/sessions" }, :path_prefix => 'devise'
    devise_scope :users do 
      get '/devise/users/sign_out' => 'sessions#destroy'
    end
    resources :product_categories
    resources :users  
    resources :roles
    resources :permissions
    resources :role_permissions
    resources :role_users
    get 'tests', to: 'tests#index'
    resources :settings
    resources :products_imports, only: [:new, :create]
    resources :client_signups, controller: 'client_signups', only: [:new]
    post '/client_signups/new', to: 'clients#sign_up', as: :signup
    get '/recipe/unit', to: 'products#get_unit', as: :products_get_unit
    get '/purchases/product_info', to: 'purchases#get_product_info', as: :purchases_get_product_info
    resources :purchases
    resources :purchase_products
    resources :suppliers
    get 'reports/client_report', as: :client_report
    get 'reports/product_report', as: :product_report 
    get 'reports/purchase_report', as: :purchase_report
    get '/reports/inventory_report', as: :inventory_report
    resources :purchase_reports
    resources :inventories
    resources :inventory_summaries
    resources :orders
    get '/products/price', to: 'products#get_price', as: :products_get_price
    resources :products     
    resources :order_products
    resources :product_reports
    resources :clients
    resources :client_reports
  end
end


