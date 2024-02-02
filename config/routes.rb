Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :products
  end
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
  # authenticate :admin do
  #   namespace :admin do
  #     resources :products, only: [:index, :new, :create]
  #     # Add other admin resources here
  #   end
  # end
end
