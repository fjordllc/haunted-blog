Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  resources :blogs
  resources :my_blogs
  root 'blogs#index'
end
