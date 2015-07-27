class DashboardsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :show]

  # skip_authorization_check only: [:index, :show]
  
  before_action do
    request.format = :json
  end

  def show
    active_projects = Project.where(active: true)
    not_started = active_projects.where(in_progress: false)

    if current_user
      @user_projects = active_projects.where(author_id: current_user.id)
      @other_projects = not_started.where.not(author_id: current_user.id)
    else
      raise "error"
    end
  end

end