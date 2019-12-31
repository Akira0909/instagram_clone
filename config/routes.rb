Rails.application.routes.draw do

  root 'static_pages#home'
  get '/terms', to:'static_pages#terms'
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :users, only: [:index, :show] do
    member do
      get :following, :followers, :likes
    end
  end
  get '/picture_edit', to:'users#picture_edit'
  post 'users/:id/picture_update', to:'users#picture_update'
  post '/picture_delete', to:'users#picture_delete'
  resources :microposts do
    resources :comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :notifications, only: :index
end