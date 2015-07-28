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
    @project = current_user.projects.create!(create_project_params)
    authorize! :create, @project
    if @project.save
      render :show
      flash[:notice] = "Project was successfully created."
    else
      redirect_to :back
      flash[:notice] = "An error occured creating your project."
    end
  end

  def edit
    @project = Project.find params[:id]
  end

  def update
    @project = Project.find params[:id]

    @project.update(edit_project_params)
    if @project.save
      render :show
      flash[:notice] = "Project was successfully updated."
    end
  end

  def destroy
    @project = Project.find params[:id]

    @project.delete
    head :ok
  end

  # def request
  #   PartnershipMailer.partnership_request(project, current_user).deliver_later
  #   create_request
  #   head :ok
  # end

  # def confirm
  #   # create_partnership
  #   # Send confirmation to requestor
  #   # open_chat
  #   head :ok
  # end

private

  def create_project_params
    params.require(:project).permit(:title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
  end

  def edit_project_params
    params.require(:project).permit(:title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
  end

end