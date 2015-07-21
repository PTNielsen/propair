Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }

  resources :users do
    resources :projects
    resources :feedbacks
    resources :partnerships
  end

  resource :dashboard, only: [:show]

  root to: "home#index"

  # get  "/dashboard" => "dashboard#show", as: :dashboard
end