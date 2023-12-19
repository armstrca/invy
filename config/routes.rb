#/workspaces/Inventory-Management-System/config/routes.rb
Rails.application.routes.draw do
  # you can remove commented out code
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/products/index', to: 'products#index'
  get '/forgot_password', to: 'users#forgot_password'
  devise_for :users, :controllers => { :registrations => "custom_devise/registrations" }
  resources :users
  resources :storage_locations
  resources :roles
  resources :inventory_transactions
  resources :order_items
  get 'orders/incoming', to: 'orders#incoming', as: :incoming_orders
  get 'orders/outgoing', to: 'orders#outgoing', as: :outgoing_orders
  get '/orders/index', to: 'orders#index'
  resources :orders do
    member do
      delete 'remove_product/:product_id', to: 'orders#remove_product', as: 'remove_product'
    end
  end
  resources :orders
  resources :suppliers
  resources :categories
  resources :products
  resources :subcategories
  get "search", to: "search#index"
  get "/subcategories_by_category", to: "products#subcategories_by_category"

  root "products#index"
  # match "*path", to: "errors#not_found", via: :all
  # get 'errors/not_found'
  # get 'errors/internal_server_error'
end
