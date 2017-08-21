Rails.application.routes.draw do

  devise_for :users
  resources :records, only: [:index, :show]

  root to: 'users#dashboard'

end
