Rails.application.routes.draw do
  root 'pages#index'
  get '/signup', to:'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post '/guest_login', to: 'users#guest_login'
  resources :users do
  end
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :pages do
    resources :comments, only: [:create, :destroy]
  end
end
