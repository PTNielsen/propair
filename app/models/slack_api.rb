require 'httparty'
require 'pry'

class SlackApi

  def propair_owner_token
    ENV["propair_owner_token"]
  end

  include HTTParty
  base_uri "https://slack.com/api"

  def create_group project
    @channel = SlackApi.post "/groups.create",
      body: {
        token: propair_owner_token,
        name: "#{project.title}"
      }
    partnership = Partnership.where(project_id: project.id)
    partnership.update(slack_channel: "#{@channel.body.id}")
  end

  def bot_message
    SlackApi.post "/chat.postMessage",
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
    SlackApi.post "/groups.invite",
      body: {
        token: propair_owner_token,
        channel: "#{@channel.body.id}",
        user: user1.slack["uid"]
      }
    SlackApi.post "/groups.invite",
      body: {
        token: propair_owner_token,
        channel: "#{@channel.body.id}",
        user: user2.slack["uid"]
      }
    bot_message
  end

  def post_message current_user, text, partnership
    SlackApi.post "/chat.postMessage",
      body: {
        token: "#{current_user.slack["credentials"]["token"]}",
        channel: "#{partnership.slack_channel}",
        text: text,
        as_user: true
      }
  end

  def chat_history partnership
    SlackApi.get "/groups.history",
    body: {
      token: propair_owner_token,
      channel: "#{partnership.slack_channel}"
    }
  end

  def screenhero current_user, text, partnership
    text_entry = text.split(" ")[1]
    SlackApi.post "/chat.command",
      body: {
        agent: "webapp",
        command: "/hero",
        text: text_entry,
        token: propair_owner_token,
        channel: "#{partnership.slack_channel}"
      }
  end

end