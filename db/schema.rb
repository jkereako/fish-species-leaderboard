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

ActiveRecord::Schema.define(version: 20150501171754) do

  create_table "catches", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "species",              default: "", null: false
    t.integer  "length_in_inches",     default: 0,  null: false
    t.string   "bait_used",            default: "", null: false
    t.string   "location_description", default: "", null: false
    t.datetime "caught_at",                         null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "catches", ["species"], name: "index_catches_on_species"
  add_index "catches", ["user_id"], name: "index_catches_on_user_id"

  create_table "competitions", force: :cascade do |t|
    t.integer  "winner_id",            default: 0,    null: false
    t.string   "name",                 default: "",   null: false
    t.string   "prize",                default: "",   null: false
    t.datetime "begins_at",                           null: false
    t.datetime "ends_at",                             null: false
    t.boolean  "is_active",            default: true, null: false
    t.integer  "winner_catches_count", default: 0,    null: false
    t.integer  "users_count",          default: 0,    null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "competitions", ["name"], name: "index_competitions_on_name", unique: true
  add_index "competitions", ["winner_id"], name: "index_competitions_on_winner_id"

  create_table "competitions_users", force: :cascade do |t|
    t.integer "competition_id", null: false
    t.integer "user_id",        null: false
  end

  add_index "competitions_users", ["competition_id"], name: "index_competitions_users_on_competition_id"
  add_index "competitions_users", ["user_id"], name: "index_competitions_users_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,    null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "name",                   default: "",   null: false
    t.string   "role",                   default: "",   null: false
    t.boolean  "is_active",              default: true, null: false
    t.integer  "catches_count",          default: 0,    null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
