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
      post :add_to_shopping_list
    end
  end

  resources :ingredients do
    collection do
      get :search
    end
  end

end