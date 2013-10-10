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

ActiveRecord::Schema.define(version: 20131010135853) do

  create_table "ruby_application_ruby_gem_relationships", force: true do |t|
    t.integer  "ruby_application_id"
    t.integer  "ruby_gem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ruby_applications", force: true do |t|
    t.string   "name"
    t.string   "filename"
    t.string   "gems_url"
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
    t.string   "desc"
    t.string   "version_fix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.string   "comment"
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
  end

end
