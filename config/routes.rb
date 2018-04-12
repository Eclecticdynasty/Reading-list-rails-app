Rails.application.routes.draw do
  
  

  #root home controller
  root 'welcome#home'

  
  #users controller
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  #Nested
  resources :users, :only => [:show] do
    resources :recipes, :only => [:new, :create, :show, :index, :edit, :update]
  end

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  get '/auth/facebook/callback' => 'sessions#create'

  
  resources :sessions, only: [:new, :create, :destroy]

  resources :recipes

 
end
