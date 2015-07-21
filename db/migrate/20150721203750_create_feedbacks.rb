class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer  "author_id"
      t.integer  "receiver"
      t.integer  "project_id"
      t.text     "body"
      t.integer  "rating"

      t.timestamps null: false
    end
  end
end