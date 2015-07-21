Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  resources :users do
    resources :connections
    resources :projects
    resources :feedbacks
    resources :partnerships
  end

  resources :projects
  
  root to: "home#index"
end