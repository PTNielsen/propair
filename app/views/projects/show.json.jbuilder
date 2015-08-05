json.(@project, :id, :author_id, :partner_id, :title, :description, :required_skill_1, :required_skill_2, :required_skill_3, :remote, :availability, :deadline, :active, :in_progress)
json.creator_name @project.author.user_name

if @project.author_id == current_user.id
  @requests.each do |request|
    json.(@request, :id, :requestor_id, :project_id, :author_id)
  end
end