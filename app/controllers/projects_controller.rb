class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  skip_authorization_check only: [:index, :show, :partner_request, :partnership_confirmation, :my_projects, :other_projects]
  
  before_action do
    request.format = :json
  end

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find params[:id]
  end

  def my_projects
    active_projects  = Project.where(active: true)

    @user_projects   = active_projects.where(author_id: current_user.id)
    @my_partnerships = active_projects.where(partner_id: current_user.id)
  end

  def other_projects
    active_projects = Project.where(active: true)
    not_started     = active_projects.where(in_progress: false)

    @other_projects = not_started.where.not(author_id: current_user.id)
  end

  def new
    project = Project.new
    authorize! :create, project
  end

  def create
    project = current_user.projects.create!(create_project_params)
    authorize! :create, project
    if project.save
      flash[:notice] = "Project was successfully created."
    else
      flash[:notice] = "An error occured creating your project."
    end
    head :ok
  end

  def edit
    project = Project.find params[:id]
    authorize! :update, project
  end

  def update
    project = Project.find params[:id]
    authorize! :update, project

    project.update(edit_project_params)
    if project.save
      flash[:notice] = "Project was successfully updated."
    end
    head :ok
  end

  def destroy
    project = Project.find params[:id]
    authorize! :destroy, project

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
    request = Request.where(project_id: project.id).last
    project.update!(partner_id: request.requestor_id)

    project.create_partnership

    project.open_chat
    PartnershipMailer.partnership_confirmation(project, request).deliver_later
    head :ok
  end

  def close
    project = Project.find params[:id]
    authorize! :update, project

    project.update(in_progress: false, active: false)
    head :ok
  end

private

  def create_project_params
    params.require(:project).permit(:title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :in_progress)
  end

  def edit_project_params
    params.require(:project).permit(:title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
  end

end