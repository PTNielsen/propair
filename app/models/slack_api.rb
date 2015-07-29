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

  def bot_message
    Slack.post "/chat.postMessage",
      body: {
        token: propair_owner_token,
        channel: "#{@channel.body.id}",
        username: "ProPair",
        icon_url: "http://media.moddb.com/images/members/1/214/213699/icon_stormtrooper.png",
        text: "Welcome to ProPair! If you'd like to pair remotely using Slack's Screenhero integration, please enter the following slash command to begin a screensharing session with your partner: ```/hero @(PARTNER_USERNAME)``` For additional Screenhero slash commands, enter: ```/hero help``` **IMPORTANT NOTE:  Use of Slack's Screenhero integration requires an existing Screenhero account with the same email address as your Slack account.  To sign up for a free account, please visit <https://screenhero.com/login/|Screenhero>**"
      }
  end

  def place_participants user1, user2, project
    create_group project
    Slack.post "/groups.invite",
      body: {
        token: propair_owner_token,
        channel: "#{@channel.body.id}",
        user: user1.slack["uid"]
      }
    Slack.post "/groups.invite",
      body: {
        token: propair_owner_token,
        channel: "#{@channel.body.id}",
        user: user2.slack["uid"]
      }
    bot_message
  end

  def post_message current_user
    Slack.post "/chat.postMessage",
      body: {
        token: "#{current_user.slack["credentials"]["token"]}",
        channel: "",
        text: "Text to be received from user"
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