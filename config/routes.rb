Rails.application.routes.draw do
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "about" => "static_pages#about"
  devise_for :users

  namespace :admin do
    root "users#index"
    resources :users
    resources :categories
  end
end
