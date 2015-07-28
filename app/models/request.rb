class Request < ActiveRecord::Base
  belongs_to :requestor, class_name: "User"
  belongs_to :project
end