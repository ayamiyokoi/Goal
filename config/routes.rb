Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:show]
  root to: 'homes#top'
  get '/about' => 'homes#about'
  resources :follows, only: [:index, :create, :destroy]
  resources :events, :reviews, :groups
  resources:tasks, except: [:new]
  resources :goals, except: [:new, :show]
  get 'notifications/destroy_all' => 'notifications#destroy_all'
  resources :notifications, only: [:index]
  resources :likes, only: [:create, :destroy]
  resources :tags, only: [:index, :create, :update, :destroy]
  resources :comments, only: [:index, :create, :update, :destroy]
  resources :chats, only: [:index, :create, :update, :destroy]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
