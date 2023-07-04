Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users
  resources :spend_transactions, path: 'transactions'
  resources :spend_categories, path: 'categories'
  get '/welcome', to: 'home#welcome'
  root "spend_categories#index"
end
