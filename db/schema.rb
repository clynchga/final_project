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

ActiveRecord::Schema.define(version: 20141128200137) do

  create_table "links", force: true do |t|
    t.integer  "request_id"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.integer  "publication_id"
    t.text     "date"
    t.integer  "seq"
    t.integer  "ed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "img_url"
    t.text     "lccn"
    t.text     "datefield"
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.text     "ocr_text"
  end

  create_table "publications", force: true do |t|
    t.text     "title"
    t.text     "state"
    t.text     "city"
    t.text     "lccn"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "sort_title"
  end

  create_table "requests", force: true do |t|
    t.text     "url"
    t.text     "state"
    t.text     "lccn"
    t.text     "andtext"
    t.text     "ortext"
    t.text     "phrasetext"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year1"
    t.integer  "month1"
    t.integer  "day1"
    t.integer  "year2"
    t.integer  "month2"
    t.integer  "day2"
    t.integer  "num_pages"
    t.integer  "index1"
    t.integer  "index2"
  end

  create_table "saves", force: true do |t|
    t.integer  "page_id"
    t.integer  "user_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", force: true do |t|
    t.integer  "request_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
