Rails.application.routes.draw do
  root "static_pages#index"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users, only: [:new, :create]
  namespace :admin do
    resources :users, only: :index
  end
end
