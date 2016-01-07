Rails.application.routes.draw do
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "about" => "static_pages#about"
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: "exams#index", as: "authenticated_root"
    end

    unauthenticated do
      root to: "static_pages#home", as: "root"
    end
  end
  resources :questions

  namespace :admin do
    root "categories#index"
    resources :users
    resources :categories
    resources :questions
    resources :imports, only: :create
    resources :exams
  end

  resources :exams
end
