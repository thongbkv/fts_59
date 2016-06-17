Rails.application.routes.draw do
  root "static_pages#index"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users, only: [:new, :create]
  namespace :admin do
    root "users#index"
    resources :users, only: :index
    resources :subjects, only: [:new, :create]
    resources :questions do
      resources :answers, only: [:new, :create]
    end
  end
end
