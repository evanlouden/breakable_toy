Rails.application.routes.draw do
  devise_for :users
  root 'courses#index'
  resources :courses do
    resources :holes, only: [:create, :edit, :destroy]
  end
  resources :matches
end
