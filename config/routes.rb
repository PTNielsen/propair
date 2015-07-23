Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'auth'}

  resources :users
  resources :projects

  resource :dashboard, only: [:show]

  root to: "dashboards#show"
end