require 'httparty'
require 'pry'

class SlackApi

  propair_owner_token = ENV["propair_owner_token"]

  ghaea_id = ENV["ghaea_id"]
  patrick_id = ENV["patrick_id"]

  include HTTParty
  base_uri "https://slack.com/api"

  def create_group project
    @channel = Slack.post "/groups.create",
      body: {
        token: propair_owner_token,
        name: "project.title"
      }
  end

  def invite user1, user2, project
    create_group
    Slack.post "/groups.invite",
      body: {
        token: propair_owner_token,
        channel: "@channel.body.name",
        user: ghaea_id
      }
    Slack.post "/groups.invite",
      body: {
        token: propair_owner_token,
        channel: "@channel.body.name",
        user: patrick_id
      }
  end

  # def screenhero
  #   Slack.post "/chat.command",
  #     body: {
  #       agent: "webapp",
  #       command: "/hero",
  #       text: "@james",
  #       token: propair_owner_token,
  #       channel: "G08355R6U"
  #     }
  # end
end