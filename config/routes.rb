Rails.application.routes.draw do
  get 'properties/show'
  devise_for :users
  root "home#index"
  resources :properties, only: :show
end
