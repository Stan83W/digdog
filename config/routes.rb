Rails.application.routes.draw do


  get '/dashboard', to: "users#dashboard"

  resources :users
  resources :records
  resources :wants
  resources :findings

  devise_for :users
  root to: 'pages#home'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
