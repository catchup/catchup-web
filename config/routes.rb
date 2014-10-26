Rails.application.routes.draw do
  resources :boards, only: [:create, :index, :show] do
    match :toggle_subscription, on: :member, via: [:patch, :put]

    resources :cards, only: [:create, :show] do
      match :move, on: :member, via: [:patch, :put]
      match :archive, on: :member, via: [:patch, :put]
    end
  end

  resources :cards, only: [] do
    resources :comments, only: :create
    resources :previews, only: :create
  end

  root to: 'users#new'

  resources :users, only: [:create]
end
