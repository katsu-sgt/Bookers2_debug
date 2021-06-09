Rails.application.routes.draw do
  get 'group_users/create'
  get 'group_users/destroy'
  root 'homes#top'
  get 'home/about' => 'homes#about'
  
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships,only:[:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  get '/search' => 'searches#search'
  resources :groups, exept: [:destroy]
  
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  
end