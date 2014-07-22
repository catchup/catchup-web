Rails.application.routes.draw do
  resources :boards, only: [:create, :index, :show] do
    resources :cards, only: [:create, :update]
  end

  root to: 'users#new'

  resources :users, only: [:create]
end
