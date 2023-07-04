Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users
  resources :spend_categories, path: 'categories'do
    resources :spend_transactions, path: 'transactions'
  end
  get '/welcome', to: 'home#welcome'
  root "spend_categories#index"
end
