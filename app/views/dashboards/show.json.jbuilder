json.array! @user_projects do |p|
  json.(p, :id, :author_id, :title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
end

json.array! @other_projects do |p|
  json.(p, :id, :author_id, :title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
end