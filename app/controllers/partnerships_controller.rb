class PartnershipsController < ApplicationController
  
  before_action do
    request.format = :json
  end

  def index
  end

  def show
  end

  def new
    @partnership = Partnership.new
  end

  def create
    @project = Project.find params[:id]
    @partnership = Partnership.create!(create_partnership_params)
    @project.update(in_progress: true)
    
    if @partnership.save
      redirect_to project_path(@project)
      flash[:notice] = "Flash message stuff"
    end
  end

  # def confirm
  #   confirm partnership requestv 
  # end

private

  def create_partnership_params
    params.require(:partnership).permit(:author_id, :partner_id, :project_id)
  end

end