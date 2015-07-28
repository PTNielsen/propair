Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'auth'}

  resources :users
  resources :projects do
    resources :chat
  end

  resource :dashboard, only: [:show]

  root to: "dashboards#show"

  post "/projects/:id/request" => "projects#partner_request", as: :partner_request

  post "/projects/:id/confirm" => "projects#confirm", as: :confirm

  # get '/sign_in' => 'pages#login', as: :sign_in
  # devise_scope :user do
  #   delete '/sign_out' => 'devise/sessions#destroy', as: :sign_out
  # end

  # get '/auth/slack/callback', to: 'sessions#create'

  # authenticate :user do
  #   mount Sidekiq::Web => '/sidekiq'
  # end
end