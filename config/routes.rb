Rails.application.routes.draw do
  
  root 'welcome#home'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  resources :users

  resources :workouts
end
