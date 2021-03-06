require 'httparty'
require 'pry'

class SlackApi

  include HTTParty
  base_uri "https://slack.com/api"

  def create_group project
    @channel = SlackApi.post "/groups.create",
      body: {
        token: propair_owner_token,
        name:  "#{project.title}"
      }
    partnership = Partnership.where(project_id: project.id)
    partnership.update(slack_channel: "#{@channel.body.id}")
  end

  def bot_message
    SlackApi.post "/chat.postMessage",
      body: {
        token:    propair_owner_token,
        channel:  "#{@channel.body.id}",
        username: "ProPair",
        icon_url: "http://media.moddb.com/images/members/1/214/213699/icon_stormtrooper.png",
        text:     "If you'd like to pair remotely using Screenhero, please enter '/hero @PARTNER_USERNAME' to begin a screensharing session. ** IMPORTANT NOTE:  Use of Slack's Screenhero integration requires an existing Screenhero account with the same email address as your Slack account.  Both users must be signed in.  To sign up for a free account, please visit https://screenhero.com/login **"
        # if we could embed slack - text: "Welcome to ProPair! If you'd like to pair remotely using Slack's Screenhero integration, please enter the following slash command to begin a screensharing session with your partner: ```/hero @(PARTNER_USERNAME)``` For additional Screenhero slash commands, enter: ```/hero help``` **IMPORTANT NOTE:  Use of Slack's Screenhero integration requires an existing Screenhero account with the same email address as your Slack account.  To sign up for a free account, please visit <https://screenhero.com/login/|Screenhero>**"
      }
  end

  def place_participants user1, user2, project
    create_group project
    SlackApi.post "/groups.invite",
      body: {
        token:   propair_owner_token,
        channel: "#{@channel.body.id}",
        user:    user1.slack["uid"]
      }
    SlackApi.post "/groups.invite",
      body: {
        token:   propair_owner_token,
        channel: "#{@channel.body.id}",
        user:    user2.slack["uid"]
      }
    bot_message
  end

  def post_message current_user, text, partnership
    SlackApi.post "/chat.postMessage",
      body: {
        token:   "#{current_user.slack["credentials"]["token"]}",
        channel: "#{partnership.slack_channel}",
        text:    text,
        as_user: true
      }
  end

  def chat_history partnership
    message_history = SlackApi.get "/groups.history",
    query: {
      token:   propair_owner_token,
      channel: "#{partnership.slack_channel}"
    }
    slack_ids = User.slack_ids_hash
    messages  = message_history["messages"]

    messages.each do |message|
      name = slack_ids[message["user"]]
      if name
        message["user"] = name.user_name
      end
    end
  end

  def screenhero text, partnership
    text_entry = text.split(" ")[1]
    SlackApi.post "/chat.command",
      body: {
        agent:   "webapp",
        command: "/hero",
        text:    text_entry,
        token:   propair_owner_token,
        channel: "#{partnership.slack_channel}"
      }
  end

  private

  def propair_owner_token
    ENV["propair_owner_token"]
  end

end