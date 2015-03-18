Rails.application.routes.draw do

  resources :reps, only: [:index, :show], param: :cid do
    resources :posts do
      resources :comments
    end
  end

  root 'landing#visitors'

  get 'auth/twitter/callback' => 'sessions#create'

  get 'auth/twitter/failure' => 'errors#index'

  resources :users

  get '/logout' => 'sessions#destroy'

  get '/visitors' => 'landing#visitors'

end
