Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :records, only: [:index, :show] do
    resources :wants, only: [:create]
  end

  get 'discogs/:id' => 'discogs#show', :constraints  => {:id => /.+\.\w{3,4}/}
  resources :discogs do
    collection do
      get :add_want
      get :edit_want
      get :remove_want
      get :wantlist
      get :reload_wantlist
    end
  end
  
  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'discogs#wantlist'
end
