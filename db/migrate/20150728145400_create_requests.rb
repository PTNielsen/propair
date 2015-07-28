class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer "requestor_id"
      t.integer "project_id"
      t.integer "author_id"

      t.timestamps null: false
    end
  end
end