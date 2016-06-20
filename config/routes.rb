Rails.application.routes.draw do
  root "static_pages#index"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users, only: [:new, :create]
  resources :lessons
  namespace :admin do
    root "users#index"
    resources :lessons
    resources :users, only: :index
    resources :subjects, only: [:new, :create, :show]
    resources :subjects do
      resources :lessons, only: :show
    end
    resources :questions do
      resources :answers, only: [:new, :create]
    end
  end
end
