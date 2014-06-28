Rails.application.routes.draw do
  root to: 'questions#index'

  get 'login', to: 'users#login'
  get 'logout', to: 'users#logout'
  post 'authenticate', to: 'users#authenticate'

  namespace :api do
    resources :users, only: [:create]
    resources :activities, only: [:index]
    resources :speakers, only: [:index, :show]
    resources :questions, only: [:create, :index] do
      member do
        put :upvote
      end
    end
  end

  namespace :admin do
    root to: 'activities#index'

    resources :activities
    resources :rooms
    resources :speakers
    resources :api_keys
    resources :admins

  end
  
end
