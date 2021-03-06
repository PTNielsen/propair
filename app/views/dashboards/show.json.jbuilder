json.user_projects @user_projects do |p|
    json.(p, :id, :author_id, :partner_id, :title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
    json.creator_name p.author.user_name
end

json.other_projects @other_projects do |p|
    json.(p, :id, :author_id, :partner_id, :title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
    json.creator_name p.author.user_name
end