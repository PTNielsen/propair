Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'auth'}

  resources :users
  resources :projects

  resource :dashboard, only: [:show]

  root to: "dashboards#show"

  post "/projects/:id/slack" => "projects#slack",  as: :slack

  post "/users/invite" => "users#invite", as: :invite

  post "/projects/:id/request" => "projects#request", as: :request

  post "/projects/:id/confirm" => "projects#confirm", as: :confirm

  # get '/auth/slack/callback', to: 'sessions#create'

  # authenticate :user do
  #   mount Sidekiq::Web => '/sidekiq'
  # end
end