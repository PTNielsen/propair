class ChatController < ApplicationController
  include Tubesock::Hijack

  skip_authorization_check only: [:create, :history]

  def create
    project = Project.find params[:project_id]
    partnership = Partnership.where(project_id: project.id)
    text = params[:text]

    slack = SlackApi.new
    slack.post_message current_user, text, partnership
    head :ok
  end

  def history
    project = Project.find params[:project_id]
    partnership = Partnership.where(project_id: project.id)

    slack = SlackApi.new
    slack.chat_history
  end

  def message
    hijack do |tubesock|
      tubesock.onopen do
        tubesock.send_data "Hello, friend"
      end

      tubesock.onmessage do |data|
        tubesock.send_data "You said: #{data}"
      end
    end
  end

  # REDIS = Redis.new

  # def connection
  #   hijack do |websocket|
  #     redis = Thread.new do
  #       Redis.new.subscribe("chatroom") do |on|
  #         on.message { |_, message| websocket.send_data(message) }
  #       end
  #     end

  #     websocket.onmessage { |message| REDIS.publish("chatroom", message) }
  #     websocket.onclose { redis.kill }
  #   end
  # end

end