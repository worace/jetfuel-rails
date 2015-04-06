require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  match "/api/v1/url" => "application#index", via: :options

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :url, only: [:index, :create]
    end
  end

  get "/:short", to: "router#show"
end
