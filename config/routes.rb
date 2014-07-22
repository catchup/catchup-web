Rails.application.routes.draw do
  resources :boards, only: [:create, :index, :show] do
    resources :cards, only: [:create, :show, :update]
  end

  resources :cards, only: [] do
    resources :comments, only: :create
  end

  root to: 'users#new'

  resources :users, only: [:create]
end
