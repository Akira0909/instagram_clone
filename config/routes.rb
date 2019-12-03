Rails.application.routes.draw do
  
  root 'static_pages#home'
  get '/terms', to:'static_pages#terms'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users
  
end
