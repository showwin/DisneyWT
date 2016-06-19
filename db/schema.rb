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

ActiveRecord::Schema.define(version: 20160619115124) do

  create_table "hdl_pasts", force: :cascade do |t|
    t.string  "name",     limit: 255,              null: false
    t.integer "waittime", limit: 4,                null: false
    t.boolean "status",                            null: false
    t.string  "fastpass", limit: 255, default: "", null: false
    t.integer "period",   limit: 4,   default: 0,  null: false
    t.date    "date",                              null: false
  end

  create_table "hdl_schedules", force: :cascade do |t|
    t.date    "date",                   null: false
    t.integer "open_period",  limit: 4, null: false
    t.integer "close_period", limit: 4, null: false
  end

  add_index "hdl_schedules", ["date"], name: "index_hdl_schedules_on_date", unique: true, using: :btree

  create_table "sdl_pasts", force: :cascade do |t|
    t.string  "name",     limit: 255,              null: false
    t.integer "waittime", limit: 4,                null: false
    t.boolean "status",                            null: false
    t.string  "fastpass", limit: 255, default: "", null: false
    t.integer "period",   limit: 4,   default: 0,  null: false
    t.date    "date",                              null: false
  end

  create_table "sdl_schedules", force: :cascade do |t|
    t.date    "date",                   null: false
    t.integer "open_period",  limit: 4, null: false
    t.integer "close_period", limit: 4, null: false
  end

  add_index "sdl_schedules", ["date"], name: "index_sdl_schedules_on_date", unique: true, using: :btree

  create_table "tdl_pasts", force: :cascade do |t|
    t.string  "name",     limit: 255,              null: false
    t.integer "waittime", limit: 4,                null: false
    t.boolean "status",                            null: false
    t.string  "fastpass", limit: 255, default: "", null: false
    t.integer "period",   limit: 4,   default: 0,  null: false
    t.date    "date",                              null: false
  end

  create_table "tdl_schedules", force: :cascade do |t|
    t.date    "date",                   null: false
    t.integer "open_period",  limit: 4, null: false
    t.integer "close_period", limit: 4, null: false
  end

  add_index "tdl_schedules", ["date"], name: "index_tdl_schedules_on_date", unique: true, using: :btree

  create_table "tds_pasts", force: :cascade do |t|
    t.string  "name",     limit: 255,              null: false
    t.integer "waittime", limit: 4,                null: false
    t.boolean "status",                            null: false
    t.string  "fastpass", limit: 255, default: "", null: false
    t.integer "period",   limit: 4,   default: 0,  null: false
    t.date    "date",                              null: false
  end

  create_table "tds_schedules", force: :cascade do |t|
    t.date    "date",                   null: false
    t.integer "open_period",  limit: 4, null: false
    t.integer "close_period", limit: 4, null: false
  end

  add_index "tds_schedules", ["date"], name: "index_tds_schedules_on_date", unique: true, using: :btree

end
