Rails.application.routes.draw do
  devise_for :users

  get '/profile', to: "users#profile"
  root to: 'pages#home'

  resources :blogs, only: [ :index, :create, :edit, :update, :destroy ]
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :blogs, only: [ :index ]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
