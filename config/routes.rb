Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root 'home#index'
  get 'about', to: 'about#index'
  resources :products do
    resources :reviews, only:[:new, :create, :show]
    resources :orders, only:[:create, :new]
    post 'add_to_cart', on: :member
  end
  resources :users do
    resources :orders, only: [:index]
    resources :carts, only: [:show, :update] do
      resources :cart_items, only: [:create, :destroy]
    end
  end
  namespace :admin do
    root 'products#index'
    resources :products
  end
end
