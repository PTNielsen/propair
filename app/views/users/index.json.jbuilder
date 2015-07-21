json.array! @users do |user|
  json.(user, :id, :email, :user_name, :first_name, :last_name, :about_me, :city, :skill_1, :skill_2, :skill_3, :skill_4, :skill_5, :github_link, :avatar, :admin)
end