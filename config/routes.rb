Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "users#show", as: "authenticated_root"
  end

  root 'courses#index'

  resources :courses do
    collection do
      get 'search'
    end
  end

  resources :matches do
    collection do
      get 'ghost'
    end
  end
  resources :courses, only: [:index, :new, :create]
  resources :courses, only: [:show] do
    resources :holes, only: [:create, :edit, :update]
  end
  resources :users, only: [:show, :update]
  resources :matches, only: [:new, :create, :destroy, :update]
  resources :matches, only: [:show] do
    resources :holescores, only: [:index, :show, :update]
  end
end
