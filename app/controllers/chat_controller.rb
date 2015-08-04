class ChatController < ApplicationController

  skip_authorization_check only: [:create, :history]

  before_action do
    request.format = :json
  end

  def create
    project     = Project.find params[:project_id]
    partnership = Partnership.find_by_project_id(project.id)
    text        = params[:text]

    slack = SlackApi.new
    if text.start_with?("/hero")
      slack.screenhero text, partnership
    else
      slack.post_message current_user, text, partnership
    end
    head :ok
  end

  def history
    project     = Project.find params[:project_id]
    partnership = Partnership.find_by_project_id(project.id)

    slack = SlackApi.new
    message_history = slack.chat_history partnership

    render json:message_history
  end

end