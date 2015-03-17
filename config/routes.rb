Rails.application.routes.draw do

  resources :reps, only: [:index, :show], param: :cid

  root 'reps#index'

end
