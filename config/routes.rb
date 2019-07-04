Rails.application.routes.draw do
  resources :cryptos
  devise_for :users
  root 'home#index'
  get 'home/about'
  get 'home/lookup'
  get 'home/show'
  post 'home/show' => 'home/show'
  post '/home/lookup' => 'home/lookup'
  
end
