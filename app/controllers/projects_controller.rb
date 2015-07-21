class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  skip_authorization_check only: [:index, :show]
  
  before_action do
    request.format = :json
  end

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find params[:id]
  end

  def new
    @project = Project.new
    authorize! :create, @project
  end

  def create
  end

  def edit
    @project = Project.find params[:id]
    authorize! :update, @project
  end

  def update
  end

  def destroy
    @project = Project.find params[:id]
    authorize! :destroy, @project

    @project.delete
  end

private

  def create_project_params
    params.require(:project).permit(:author_id, :title, :description, :required_skill_1, :remote, :availability, :deadline, :active, :in_progress)
  end

  def edit_project_params
    params.require(:project).permit(:title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
  end

end