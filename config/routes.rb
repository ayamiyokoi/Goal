Rails.application.routes.draw do
  get 'follows/index'
  resources :tasks
  get 'goals/index'
  get 'goals/edit'
  get 'notifications/index'
  resources :events
  get 'tags/index'
  get 'comments/index'
  resources :reviews
  get 'chats/index'
  resources :groups
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
