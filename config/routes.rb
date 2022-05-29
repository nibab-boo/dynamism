Rails.application.routes.draw do
  devise_for :users

  get '/profile', to: "users#profile"
  post '/reset_api', to: "users#reset_api"
  post '/toggle', to: "users#toggle"
  root to: 'pages#home'

  # User side
  resources :blogs, expect: [ :new, :edit ]
  resources :albums, except: [ :show ] do
    resources :album_photos, only: [ :destroy ]
  end
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :blogs, only: [ :index ]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
