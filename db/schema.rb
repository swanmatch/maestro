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

ActiveRecord::Schema.define(version: 20161123095207) do

  create_table "songs", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "composer",     limit: 255
    t.integer  "tempo",        limit: 4
    t.integer  "key",          limit: 4
    t.integer  "scale",        limit: 4
    t.text     "score",        limit: 65535
    t.integer  "lock_version", limit: 4,     default: 0, null: false
    t.integer  "created_by",   limit: 4
    t.integer  "updated_by",   limit: 4
    t.integer  "deleted_by",   limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
