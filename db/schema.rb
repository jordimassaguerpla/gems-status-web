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

ActiveRecord::Schema.define(version: 20140204144553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "last_runs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repos", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "ruby_application_ruby_gem_relationships", force: true do |t|
    t.integer  "ruby_application_id"
    t.integer  "ruby_gem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ruby_applications", force: true do |t|
    t.string   "name"
    t.string   "filename"
    t.string   "gems_url",   default: "https://rubygems.org/gems"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "ruby_gems", force: true do |t|
    t.string   "name"
    t.string   "version"
    t.string   "license"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "security_alerts", force: true do |t|
    t.integer  "ruby_gem_id"
    t.integer  "ruby_application_id"
    t.text     "desc"
    t.string   "version_fix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.string   "comment"
    t.string   "sec_key"
    t.string   "extid"
  end

  create_table "source_repos", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.integer  "admin",            default: 0
    t.integer  "role"
    t.string   "api_access_token"
    t.string   "provider"
    t.string   "uid"
    t.integer  "beta_user",        default: 0
    t.string   "auth_token"
    t.integer  "times_logged_in",  default: 0
    t.string   "password_digest"
  end

end
