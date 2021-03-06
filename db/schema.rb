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

ActiveRecord::Schema.define(version: 20160512215019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "name",    null: false
    t.string "address", null: false
    t.string "city",    null: false
    t.string "state",   null: false
    t.string "zip",     null: false
  end

  create_table "holes", force: :cascade do |t|
    t.integer "hole_number", null: false
    t.integer "par",         null: false
    t.integer "difficulty",  null: false
    t.integer "course_id",   null: false
  end

  create_table "holescores", force: :cascade do |t|
    t.integer "strokes",     default: 0
    t.integer "gross_score"
    t.integer "net_score"
    t.integer "user_id",                 null: false
    t.integer "hole_id",                 null: false
    t.integer "match_id",                null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "match_status",         default: 0,     null: false
    t.integer  "hero_id",                              null: false
    t.integer  "villain_id",                           null: false
    t.integer  "hero_adj_handicap",    default: 0,     null: false
    t.integer  "villain_adj_handicap", default: 0,     null: false
    t.integer  "course_id",                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "match_completed",      default: false
  end

  add_index "matches", ["hero_id"], name: "index_matches_on_hero_id", using: :btree
  add_index "matches", ["villain_id"], name: "index_matches_on_villain_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "handicap",                            null: false
    t.string   "username",                            null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
