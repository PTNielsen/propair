class AddSlackToUsers < ActiveRecord::Migration
  def change
    add_column :users, :slack, :json
  end
end