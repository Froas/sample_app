Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'reset/new'
  get 'reset/create'
  default_url_options :host => "example.com"
  get 'users/new'
  get 'static_pages/help'
  get "/huy", to: "static_pages#about"
  get "signup", to: "users#new"
  root 'static_pages#home'
  get "/index", to: "users#index"
  get '/login',to: 'sessions#new'
  get "/set", to: "users#admin_set", as: :set_path
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', via: :delete
  get "/delete/:id", to: "users#destroy", as: :delete_path
  
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]


end
