Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  post 'password_resets/:id', to: "password_resets#update"
  get 'reset/new'
  get 'reset/create'
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
  get "delete_blog/:id", to: "blogs#destroy", as: :delete_blog_path
  get '/resend', to: 'sessions#resend_account_activation_page'
  post 'resend_activation', to: 'sessions#resend_activation'
  post "create_new_blogs", to: "blogs#create"
  get "/blogs", to: "blogs#index"
  post "edit_my_blog", to: "blogs#update"
  get "/blogs/:id", to: "blogs#show"

  
  resources :users
  resources :blogs
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]


end
