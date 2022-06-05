Rails.application.routes.draw do
  get 'users/new'
  get 'static_pages/help'
  get "/huy", to: "static_pages#about"
  get "signup", to: "users#new"
  root 'static_pages#home'
  get "/index", to: "users#index"
  get '/login',to: 'sessions#new'
  #patch "set", to: "users#admin_set"
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', via: :delete
  get "/delete/:id", to: "users#destroy", as: :delete_path
  get "/admin", to: "users#admin_set"
  
  resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
