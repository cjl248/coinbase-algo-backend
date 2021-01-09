Rails.application.routes.draw do

  get '/c_products/get_bands', to: 'c_products#get_bands'
  resources :c_products
  resources :c_accounts
  resources :c_orders
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
