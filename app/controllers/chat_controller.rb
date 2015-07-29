class ChatController < ApplicationController
  include Tubesock::Hijack

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

  def post_message
    slack = SlackApi.new
    slack.post_message current_user
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