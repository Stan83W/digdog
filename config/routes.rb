Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :records do
    resources :wants, only: [:create] do
      collection do
        delete :destroy
      end
    end
  end

  get 'no_access' => 'pages#no_access'

  resources :discogs, only: [:show] do
    collection do
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
