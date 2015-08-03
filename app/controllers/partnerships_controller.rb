class PartnershipsController < ApplicationController
  
  before_action do
    request.format = :json
  end

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  # def partner_request
  #   project = Project.find params[:project_id]
    
  #   project.create_request current_user #FIX ME
  #   PartnershipMailer.partnership_request(project, current_user).deliver_later
  #   head :ok
  # end

  # def confirm
  #   project = Project.find params[:id]
  #   request = Request.where(project_id: project.id).last
  #   project.update!(partner_id: request.requestor_id)

  #   project.create_partnership

  #   project.open_chat
  #   PartnershipMailer.partnership_confirmation(project, request).deliver_later
  #   head :ok
  # end

end