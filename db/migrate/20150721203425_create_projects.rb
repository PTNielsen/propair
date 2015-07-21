class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer  "author_id"
      t.string   "title"
      t.text     "description"
      t.text     "required_skill_1"
      t.text     "required_skill_2"
      t.text     "required_skill_3"
      t.boolean  "remote",          null: false, default: false
      t.string   "availability"
      t.datetime "deadline"
      t.boolean  "active",          null: false, default: false
      t.boolean  "in_progress",     null: false, default: false
      t.timestamps                  null: false
    end
  end
end