Rails.application.routes.draw do
  root to: 'tops#index'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  resources :users, only: [:index, :show, :new, :create]
end
