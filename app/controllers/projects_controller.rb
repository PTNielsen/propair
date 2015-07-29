class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  skip_authorization_check only: [:index, :show, :partner_request, :partnership_confirmation]
  
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
    project = Project.new
    authorize! :create, project
  end

  def create
    project = current_user.projects.create!(create_project_params)
    authorize! :create, project
    if project.save
      render :show
      flash[:notice] = "Project was successfully created."
    else
      redirect_to :back
      flash[:notice] = "An error occured creating your project."
    end
  end

  def edit
    project = Project.find params[:id]
  end

  def update
    project = Project.find params[:id]

    project.update(edit_project_params)
    if project.save
      render :show
      flash[:notice] = "Project was successfully updated."
    end
  end

  def destroy
    project = Project.find params[:id]

    project.delete
    head :ok
  end

  def partner_request
    project = Project.find params[:project_id]
    
    project.create_request current_user #FIX ME
    PartnershipMailer.partnership_request(project, current_user).deliver_later
    head :ok
  end

  def confirm
    project = Project.find params[:id]
    request = Request.find_by_project_id(project.id)
    project.update!(partner_id: request.requestor_id)

    project.create_partnership

    project.open_chat
    PartnershipMailer.partnership_confirmation(project, request).deliver_later
    head :ok
  end

private

  def create_project_params
    params.require(:project).permit(:title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
  end

  def edit_project_params
    params.require(:project).permit(:title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
  end

end