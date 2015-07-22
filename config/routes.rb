Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  resources :users do
    resources :projects
    resources :feedbacks
    resources :partnerships
  end

  resources :projects

  resource :dashboard, only: [:show]

  root to: "home#index"
end