Rails.application.routes.draw do

  get 'groups/create'

  post 'auth/register', to: 'users#register'	
  post 'auth/login', to: 'users#login'
  get 'test', to: 'users#test'

  resources :users
end