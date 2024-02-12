Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :products
  end
  get "up" => "rails/health#show", as: :rails_health_check
  root 'home#index'
  get 'about', to: 'about#index'
  resources :products do
    resources :reviews, only:[:new, :create, :show]
    resources :orders, only:[:create, :new]
    post 'add_to_cart', on: :member
  end

  resources :checkouts, only: [:show]
  resources :payments, only: [:show]

  resources :users do
    resources :orders, only: [:index]
    resources :carts, only: [:show, :update] do
      resources :cart_items, only: [:create, :destroy, :update]
    end
  end
  # authenticate :admin do
  #   namespace :admin do
  #     resources :products, only: [:index, :new, :create]
  #     # Add other admin resources here
  #   end
  # end
end
