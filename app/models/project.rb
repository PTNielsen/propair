class Project < ActiveRecord::Base
  validates_presence_of :author_id, :title, :description, :required_skill_1
  
  belongs_to :User
end