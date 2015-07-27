class ProjectsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :show, :create, :destroy]

  # skip_authorization_check only: [:index, :show, :create, :destroy]
  
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
    # authorize! :create, @project
  end

  def create
    @project = current_user.projects.create!(create_project_params)

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

  def slack user1, user2, project
    slack = SlackApi.new
    slack.invite user1, user2, project
    head :ok
  end

  def request
    PartnershipMailer.partnership_request(project, current_user).deliver_later
    # SlackApi.new to create group and invite both users
    head :ok
  end

  def confirm
    
    # Send confirmation to requestor, open slack chat in window, create partnership in table
  end

private

  def create_project_params
    params.require(:project).permit(:title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
  end

  def edit_project_params
    params.require(:project).permit(:title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
  end

end