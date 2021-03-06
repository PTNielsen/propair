# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150731165715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auth_tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "key"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "auth_tokens", ["key"], name: "index_auth_tokens_on_key", using: :btree
  add_index "auth_tokens", ["user_id"], name: "index_auth_tokens_on_user_id", using: :btree

  create_table "connections", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "receiver"
    t.integer  "project_id"
    t.text     "body"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partnerships", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "partner_id"
    t.integer  "project_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "slack_channel"
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "author_id"
    t.string   "title"
    t.text     "description"
    t.text     "required_skill_1"
    t.text     "required_skill_2"
    t.text     "required_skill_3"
    t.boolean  "remote",           default: false, null: false
    t.string   "availability"
    t.datetime "deadline"
    t.boolean  "active",           default: true,  null: false
    t.boolean  "in_progress",      default: false, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "partner_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "requestor_id"
    t.integer  "project_id"
    t.integer  "author_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",               null: false
    t.string   "encrypted_password",     default: "",               null: false
    t.string   "user_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "about_me"
    t.string   "city"
    t.string   "skill_1"
    t.string   "skill_2"
    t.string   "skill_3"
    t.string   "skill_4"
    t.string   "skill_5"
    t.string   "github_link"
    t.string   "avatar",                 default: "/no_avatar.jpg"
    t.boolean  "admin",                  default: false,            null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.json     "slack"
    t.string   "timezone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "auth_tokens", "users"
end
