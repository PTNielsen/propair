class Project < ActiveRecord::Base
  validates_presence_of :author_id, :title, :description
  
  belongs_to :User, class_name: "User"
end