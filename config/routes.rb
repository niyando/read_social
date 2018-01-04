Rails.application.routes.draw do

  root 'home#index'

  get '/auth/callback', to: 'sessions#create'
  get '/auth', to: 'sessions#auth'
  get '/signout', to: 'sessions#destroy', as: 'signout'

  get '/friends', to: 'users#friends'

end
