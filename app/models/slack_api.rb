require 'httparty'
require 'pry'

class SlackApi

  propair_owner_token = ENV["propair_owner_token"]

  include HTTParty
  base_uri "https://slack.com/api"

  def create_group project
    @channel = Slack.post "/groups.create",
      body: {
        token: propair_owner_token,
        name: "#{project.title}"
      }
  end

  def place_participants user1, user2, project
    create_group project
    Slack.post "/groups.invite",
      body: {
        token: propair_owner_token,
        channel: "#{@channel.body.name}",
        user: user1.slack["uid"]
      }
    Slack.post "/groups.invite",
      body: {
        token: propair_owner_token,
        channel: "#{@channel.body.name}",
        user: user2.slack["uid"]
      }
  end

  # def post_message
  # end

  # def rtm_session
  #   Slack.post "/rtm.start"#,
  #     #stuff
  # end

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