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

ActiveRecord::Schema.define(version: 20170127155415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analyses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookandchallenges", force: :cascade do |t|
    t.integer  "challenge_id"
    t.integer  "booking_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.string   "detail"
    t.integer  "amount"
    t.datetime "date"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "category_id"
    t.integer  "sort_id"
    t.boolean  "unlist",      default: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "challenges", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "start"
    t.datetime "deadline"
    t.integer  "total_amount"
    t.integer  "target"
    t.integer  "score"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "status",       default: 1
    t.boolean  "achieve",      default: false, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "messenger"
  end

  create_table "points", force: :cascade do |t|
    t.string   "name"
    t.integer  "each_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rankings", force: :cascade do |t|
    t.string   "name"
    t.integer  "threshold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sorts", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "name"
    t.integer  "continue",               default: 0
    t.integer  "total_score",            default: 0
    t.boolean  "public",                 default: true
<<<<<<< HEAD
=======
    t.string   "avatar"
>>>>>>> avatar
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "sorts", "categories"
end
