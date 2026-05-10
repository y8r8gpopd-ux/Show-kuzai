Rails.application.routes.draw do
  root to: 'fridge_items#index'
  devise_for :users

  resources :fridge_items, only: :index
  resources :ingredients, only: [:index, :new, :create]
end
