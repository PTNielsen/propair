class Project < ActiveRecord::Base

  validates_presence_of :author_id, :title, :description
    
  belongs_to :author, class_name: "User"

  has_many :requests

  def create_request current_user
    self.requests.create!(requestor_id: current_user.id, project_id: self.id, author_id: self.author_id)
  end

  def create_partnership
    request_data = Request.where(project_id: self.id)
    partnership = Partnership.create!(author_id: self.author_id, partner_id: request_data.requestor_id, project_id: self.id)
    self.update(in_progress: true)

    if partnership.save
      flash[:notice] = "Partnership created"
      head :ok
    end
  end

  def open_chat
    partnership = Partnership.find_by_project_id(self.id)
    project = Project.find(self.id)
    user1 = partnership.author_id
    user2 = partnership.partner_id

    chat = SlackApi.new
    chat.place_participants user1, user2, project
  end

end