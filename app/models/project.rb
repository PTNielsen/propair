class Project < ActiveRecord::Base

  module InitiatePartnership

    validates_presence_of :author_id, :title, :description
    
    belongs_to :author, class_name: "User"

    def create_request
      self.requests.create!(requestor_id: current_user.id, project_id: self.id, author_id: self.author_id)
    end

    def create_partnership project
      request_data = Request.where(project_id: project.id)
      partnership = Partnership.create!(author_id: project.author_id, partner_id: request_data.requestor_id, project_id: project.id)
      project.update(in_progress: true)
      
      if partnership.save
        flash[:notice] = "Partnership created"
        head :ok
      end
    end

    def open_chat project
      partnership = Partnership.find_by_project_id(project.id)
      user1 = partnership.author_id
      user2 = partnership.partner_id

      chat = SlackApi.new
      chat.place_participants user1, user2, project
    end

    def message
    end

  end

end