Rails.application.routes.draw do

  get '/c_products/get_bands', to: 'c_products#get_bands'
  get 'c_products/get_fibonacci_retracement', to: 'c_products#get_fibonacci_retracement'
  resources :c_products
  resources :c_accounts
  resources :c_orders
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
