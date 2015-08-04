# Not needed since we're sending invite emails async.

# class InvitationWorker
#   include Sidekiq::Worker

#   def perform(invitation_params)
#     @invitation = Invitation.new(invitation_params)
#     @invitation.perform
#   end
# end