class CommentMailer < ApplicationMailer
  default from: "admin@propair.com"

  # def group_created post, current_user
  #   @post, @current_user = post, current_user
  #   mail(
  #     to: post.author.email,
  #     subject: "New Comment on #{post.title}"
  #   )
  # end
end