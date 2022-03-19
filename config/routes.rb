Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  resources :blogs
  resources :my_blogs
  root 'blogs#index'

  namespace :api do
    resources :blogs, only: [] do
      resources :likings, only: %i(create destroy)
      resources :liking_users, only: :index
    end
  end
end
