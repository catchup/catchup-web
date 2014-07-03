Rails.application.routes.draw do
  resources :boards, only: [:create, :index, :new, :show]

  root to: 'users#new'

  resources :users, only: [:create]
end
