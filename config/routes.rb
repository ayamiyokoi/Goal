Rails.application.routes.draw do

  devise_for :users, controllers: {
        registrations: 'users/registrations'
      }
  root to: 'homes#top'
  get '/about' => 'homes#about'
  resources :users, :only => [:index, :show] do
    resource :follows, only: [:show, :create, :destroy]
  end
  resources :events
  get '/reviews/topics' => 'reviews#topics'
  resources :reviews do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :update, :destroy]
    get :search, on: :collection
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
  delete 'notifications/destroy_all' => 'notifications#destroy_all'
  resources :notifications, only: [:index]
  resources :inquiry, only: [:index, :create]
  get 'inquiry/confirm' => 'inquiry#confirm'
  # post 'inquiry/confirm' => 'inquiry#confirm'
  post 'inquiry/thanks' => 'inquiry#thanks'
  get 'inquiry/thank' => 'inquiry#thank'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
