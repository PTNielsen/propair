Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users
  resources :projects

  resource :dashboard, only: [:show]

  root to: "dashboards#show"
end