class Partnership < ActiveRecord::Base
  validates_presence_of :author_id, :partner_id, :project_id

  belongs_to :user
end