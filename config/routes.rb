Rails.application.routes.draw do

  root 'static_pages#home'
  get '/terms', to:'static_pages#terms'
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :users do
    member do
      get :following, :followers, :likes
    end
  end
  resources :microposts do
    resources :comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :notifications, only: :index
  
end
