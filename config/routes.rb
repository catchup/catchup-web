Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get :logout, to: "authentication#logout"

  resources :boards, only: [:create, :index, :show, :update] do
    match :toggle_subscription, on: :member, via: [:patch, :put]

    resources :cards, only: [:create, :show, :update] do
      match :move, on: :member, via: [:patch, :put]
      match :archive, on: :member, via: [:patch, :put]
    end
  end

  resources :cards, only: [] do
    resources :comments, only: :create
    resources :previews, only: :create
  end

  root to: "boards#index"
end
