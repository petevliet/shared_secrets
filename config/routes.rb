Rails.application.routes.draw do

  resources :reps, only: [:index, :show], param: :cid do
    resources :posts
  end

  root 'reps#index'

  get 'auth/twitter/callback' => 'sessions#create'

  get 'auth/twitter/failure' => 'errors#index'

  resources :users

  get '/logout' => 'sessions#destroy'

end
