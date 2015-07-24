require "slack/client"

class Invitation
  include Virtus.model
  include ActiveModel::Model

  attribute :email, String
  validates :email, presence: true

  def enqueue
    InvitationWorker.perform_async(attributes)
  end

  def perform
    slack_client.invite email: email
  end

  private

  def slack_client
    @slack_client ||= Slack::Client.new ENV.fetch("propair_owner_token")
  end
  
end