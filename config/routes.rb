Rails.application.routes.draw do
  resources :boards

  root to: 'users#new'

  resources :users, only: [:create]
end
