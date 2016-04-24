Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "courses#index", as: "authenticated_root"
  end

  root 'courses#index'

  resources :courses, only: [:index, :new, :create]
  resources :courses, only: [:show] do
    resources :holes, only: [:create]
  end
  resources :users, only: [:show]
  resources :matches, only: [:index, :new, :create]
  resources :matches, only: [:show] do
    resources :holescores, only: [:index, :show, :create, :update]
  end
end
