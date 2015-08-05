Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'auth'}

  resources :users
  resources :projects, only: [:show, :create, :update, :destroy] do
    resources :feedback, only: [:show, :create, :update, :destroy]
  end

  resource :dashboard, only: [:show]

  root to: "dashboards#show"

  # Project Routes

  get "/my_projects" => "projects#my_projects", as: :my_projects

  get "/other_projects" => "projects#other_projects", as: :other_projects

  get "/projects/:project_id/chat_history" => "chat#history", as: :chat_history
  
  post "/projects/request/:project_id" => "projects#partner_request", as: :partner_request

  post "/confirm" => "projects#confirm", as: :confirm

  patch "projects/:id/close" => "projects#close", as: :close

  post "/projects/:project_id/chat" => "chat#create", as: :create

  delete "/my_projects/:project_id" => "projects#destroy", as: :destroy

  # User Routes

  post "/users/invite" => "users#invite", as: :invite

  # get '/sign_in' => 'pages#login', as: :sign_in
  # devise_scope :user do
  #   delete '/sign_out' => 'devise/sessions#destroy', as: :sign_out
  # end

  # authenticate :user do
  #   mount Sidekiq::Web => '/sidekiq'
  # end
end