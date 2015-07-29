class AddSlackChannelToPartnership < ActiveRecord::Migration
  def change
    add_column :partnerships, :slack_channel, :string
  end
end