class Feedback < ActiveRecord::Base
  validates_presence_of :author_id, :receiver, :project_id, :body, :rating

  belongs_to :user, class_name: "User"
end