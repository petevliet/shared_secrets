Rails.application.routes.draw do

  resources :reps, only: [:index, :show], param: :cid do
    resources :posts do
      resources :comments
    end
  end

  resources :users, only: [] do
    resources :tweets, only: [:create]
  end

  root 'landing#visitors'
  get '/set_state' => 'landing#set_state'

  get 'auth/twitter/callback' => 'sessions#create'

  get '/logout' => 'sessions#destroy'

  # get 'auth/twitter/failure' => 'errors#index'

  get '/visitors' => 'landing#visitors'



end
