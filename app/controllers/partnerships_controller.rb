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
      flash[:notice] = "Flash message stuff"
      head :ok
    end
  end

private

  def create_partnership_params
    params.require(:partnership).permit(:author_id, :partner_id, :project_id)
  end

end