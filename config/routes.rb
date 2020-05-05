Rails.application.routes.draw do
  devise_for :users

  root 'home#top'
  get 'home/about' => 'home#about'
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
  end
  resources :users,only: [:show,:index,:edit,:update,:create] do
  	member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end