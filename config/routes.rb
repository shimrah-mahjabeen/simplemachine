require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
    end
  end
  mount Sidekiq::Web => '/jobmonitor'

  scope 'api/v1', defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'users', controllers: {
      registrations: 'api/v1/registrations',
      sessions: 'api/v1/sessions',
      passwords: 'api/v1/passwords',
      token_validations: 'api/v1/token_validations'
    }, skip: %i[omniauth_callbacks]

    mount_devise_token_auth_for 'User', at: 'admins', controllers: {
      registrations: 'api/v1/admin/registrations'
    }, skip: %i[omniauth_callbacks sessions passwords token_validations], as: :admin
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :user, only: %i[show update]
      resources :food_items, only: %i[index show create update destroy]
      resources :discounts, only: %i[index show create update destroy]
      resources :orders, only: %i[index show update]

      resources :shops, only: %i[index show update] do
        resources :cart_items, only: %i[index create update destroy]

        get :food_items, to: 'shops#food_items'
        get :orders, to: 'shops#orders'
        get :discounts, to: 'shops#discounts'
        post :checkout, to: 'checkout#create'
      end
    end
  end
end
