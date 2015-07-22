class DashboardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  skip_authorization_check only: [:index, :show]
  
  before_action do
    request.format = :json
  end

  def show
    active_projects = Project.where(active: true)
    not_started = active_projects.where(in_progress: false)

    @user_projects = active_projects.where(author_id: 1)
    @other_projects = not_started.where.not(author_id: 1)
  end

end