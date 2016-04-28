Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "courses#index", as: "authenticated_root"
  end

  root 'welcome#index'

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
    resources :holes, only: [:create]
  end
  resources :users, only: [:show]
  resources :matches, only: [:new, :create]
  resources :matches, only: [:show] do
    resources :holescores, only: [:index, :show, :update]
  end

  resources :welcome, only: [:index]
end
