Rails.application.routes.draw do
  resources :boards, only: [:create, :index, :new, :show] do
    resources :lists, only: [] do
      resources :cards, only: [:create]
    end
  end

  root to: 'users#new'

  resources :users, only: [:create]
end
