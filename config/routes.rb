Rails.application.routes.draw do

  get 'auth/twitter/callback' => 'sessions#create'

  get 'auth/twitter/failure' => 'errors#index'

  resources :users

  root 'home#index'

  get '/logout' => 'sessions#destroy'

end
