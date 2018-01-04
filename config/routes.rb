Rails.application.routes.draw do

  root 'user#index'

  get '/auth/callback', to: 'sessions#create'
  get '/auth', to: 'sessions#auth'
  get '/signout', to: 'sessions#destroy', as: 'signout'

end
