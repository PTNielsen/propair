json.array! @projects do |project|
  json.(project, :id, :author_id, :title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
end