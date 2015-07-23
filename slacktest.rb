require 'httparty'
require 'pry'

class Slack

  propair_owner_token = ENV["propair_onwer_token"]

  james_id = ENV["james_id"]
  ghaea_id = ENV["ghaea_id"]

  include HTTParty
  base_uri "https://slack.com/api"
end

    # r = Slack.post "/groups.create",
    #   body: {
    #     token: propair_owner_token,
    #     name: Time.now
    #   }

    a = Slack.post "/groups.invite",
      body: {
        token: propair_owner_token,
        channel: "G08355R6U",
        user: ghaea_id
      }

    # p = Slack.post "/chat.command",
    #   body: {
    #     agent: "webapp",
    #     command: "/hero",
    #     text: "@james",
    #     token: propair_owner_token,
    #     channel: "G08355R6U"
    #   }

binding.pry