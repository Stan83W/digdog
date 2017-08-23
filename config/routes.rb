Rails.application.routes.draw do

  devise_for :users
  resources :records, only: [:index, :show]

  get 'discogs/:id' => 'discogs#show', :constraints  => {:id => /.+\.\w{3,4}/}

  resources :discogs do
    collection do
      get :authenticate
      get :callback
      get :whoami
      get :add_want
      get :edit_want
      get :remove_want
      get :wantlist
    end
  end

  root to: 'users#dashboard'

end
