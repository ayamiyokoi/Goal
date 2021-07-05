Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/about' => 'homes#about'
  resources :users, :only => [:index, :show] do
    resource :follows, only: [:show, :create, :destroy]
  end
  resources :events
  resources :reviews do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :update, :destroy]
  end
  resources :groups, except: [:new] do
    member do
      get :join
    end
    resources :chats, only: [:index, :create, :destroy]
  end

  resources :tasks, except: [:new] do
    member do
      get :confirm
    end
  end

  resources :goals, except: [:new, :show]
  get 'notifications/destroy_all' => 'notifications#destroy_all'
  resources :notifications, only: [:index]
  
  resources :tags, only: [:index, :create, :update, :destroy]
  


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
