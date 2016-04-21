Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
   root to: "courses#index", as: "authenticated_root"
  end

  root 'courses#index'
  resources :courses do
    resources :holes, only: [:create, :edit, :destroy]
  end
  resources :matches
end
