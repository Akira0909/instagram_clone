Rails.application.routes.draw do
  get 'users/new'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'static_pages#home'
  
end
