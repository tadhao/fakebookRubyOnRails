Rails.application.routes.draw do
 resources :friendships, only: [:create, :update, :destroy]

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'pages/about', to: 'pages#about'
  resources :articles
end
