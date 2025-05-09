Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API Routes
  namespace :api do
    namespace :v1 do
      # Auth routes
      namespace :auth do
        post 'check_user', to: 'sessions#check_user'  # Add this line
        post 'signup', to: 'registrations#create'
        post 'complete_registration', to: 'registrations#complete_registration'
        post 'login', to: 'sessions#create'
        delete 'logout', to: 'sessions#destroy'
      end

      # User profile routes
      resource :profile, only: [:show, :update], controller: 'user_profiles'

      # Addresses routes
      resources :addresses, only: [:index, :create, :update, :destroy]

      # Restaurants routes
      resources :restaurants, only: [:index, :show, :create, :update, :destroy]

      # Categories routes
      resources :categories, only: [:index]
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
