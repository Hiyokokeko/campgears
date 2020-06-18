Rails.application.routes.draw do
  root 'pages#index'
  get '/signup', to:'users#new'
  post '/signup', to: 'users#create'
end
