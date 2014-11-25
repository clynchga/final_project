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

ActiveRecord::Schema.define(version: 20141125010733) do

  create_table "pages", force: true do |t|
    t.integer  "publication_id"
    t.text     "date"
    t.integer  "seq"
    t.integer  "ed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "img_url"
  end

  create_table "publications", force: true do |t|
    t.text     "title"
    t.text     "state"
    t.text     "city"
    t.text     "lccn"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  create_table "requests_pages", id: false, force: true do |t|
    t.integer "request_id", null: false
    t.integer "page_id",    null: false
  end

end
