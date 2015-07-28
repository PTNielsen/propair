class Project < ActiveRecord::Base
  validates_presence_of :author_id, :title, :description
  
  belongs_to :author, class_name: "User"

  def open_chat
    project = Project.find params[:id]
    partnership = Partnership.find_by_project_id(project.id)
    user1 = partnership.author_id
    user2 = partnership.partner_id

    chat = SlackApi.new
    chat.place_participants user1, user2, project
  end

  # def create_partnership
  #   @project = Project.find params[:id]
  #   @partnership = Partnership.create!(create_partnership_params)
  #   @project.update(in_progress: true)
    
  #   if @partnership.save
  #     flash[:notice] = "Flash message stuff"
  #     head :ok
  #   end
  # end

  # def create_request
  # end

end