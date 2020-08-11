Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  resources :users, only: [:show]

  get 'profile', to: 'users#profile'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
