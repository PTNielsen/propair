require 'net/http'
require 'httparty'

module Slack
  class Client
    RequestFailed = Class.new(StandardError)
    InviteFailed = Class.new(StandardError)

    include HTTParty

    def initialize token
      @token = token
    end

    def invite(email:, channels: [])
      res = Net::HTTP.start("propair.slack.com", 443, use_ssl: true) do |http|
        req = Net::HTTP::Post.new("/api/users.admin.invite?t=#{Time.now.to_i}")
        req.set_form_data \
          email:       email,
          channels:    channels.join(","),
          token:       @token,
          set_active:  "true",
          _attempts:   1

        http.request(req)
      end

      #SlackApi.post ("/api/users.admin.invite?t=#{Time.now.to_i}")

      raise RequestFailed.new("HTTP status code: #{res.to_i}") unless res.is_a?(Net::HTTPSuccess)

      body = JSON.parse(res.body)
      if !(body["ok"] || %w(already_in_team already_invited sent_recently).include?(body["error"]))
        raise InviteFailed.new(body.to_s)
      end

      true
    end
  end
end