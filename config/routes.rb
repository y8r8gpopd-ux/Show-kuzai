Rails.application.routes.draw do
  root to: 'fridge_items#index'
  devise_for :users

  resources :fridge_items, only: [:index, :create, :update] do
    collection do
      get :manage
    end
  end
  
  resources :recipes do
    member do
      patch :cook
    end
  end

  resources :ingredients, only: [:index, :new, :create]

end