Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  get "up" => "rails/health#show", as: :rails_health_check


  namespace :api do
    namespace :v1 do
      resources :users, only: [:index,:create]
      post 'auth/login', to: 'authentication#login'
      resources :messages, only: [:create, :index]
    end
  end
end
