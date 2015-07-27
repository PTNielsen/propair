class Project < ActiveRecord::Base
  validates_presence_of :author_id, :title, :description
  
  belongs_to :author, class_name: "User"
end