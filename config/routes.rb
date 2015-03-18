Rails.application.routes.draw do

  resources :reps, only: [:index, :show], param: :cid

  root 'landing#dashboard'

  get 'auth/twitter/callback' => 'sessions#create'

  get 'auth/twitter/failure' => 'errors#index'

  resources :users

  get '/logout' => 'sessions#destroy'

  get '/visitors' => 'landing#visitors'

end
