Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get "/auth/signout", to: "authentication#signout"
  get "/auth/github/callback", to: "authentication#github"
  get "/auth/failure", to: "authentication#failure"

  resources :boards, only: [:create, :index, :show, :update] do
    match :toggle_subscription, on: :member, via: [:patch, :put]

    resources :cards, only: [:create, :show, :update] do
      match :move, on: :member, via: [:patch, :put]
      match :archive, on: :member, via: [:patch, :put]
    end
  end

  resources :cards, only: [] do
    resources :comments, only: [:create, :update]
    resources :previews, only: :create
  end

  root to: "welcome#index"

  # Forwarding
  post "/forward/store_redirect", to: "forward#store_redirect"
  get "/forward", to: "forward#redirect"
end
