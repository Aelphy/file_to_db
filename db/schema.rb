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

ActiveRecord::Schema.define(version: 20140328234755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entities", force: true do |t|
    t.float    "column_1"
    t.float    "column_2"
    t.float    "column_3"
    t.float    "column_4"
    t.float    "column_5"
    t.float    "column_6"
    t.float    "column_7"
    t.float    "column_8"
    t.float    "column_9"
    t.float    "column_10"
    t.float    "column_11"
    t.float    "column_12"
    t.float    "column_13"
    t.float    "column_14"
    t.float    "column_15"
    t.float    "column_16"
    t.float    "column_17"
    t.float    "column_18"
    t.float    "column_19"
    t.float    "column_20"
    t.float    "column_21"
    t.float    "column_22"
    t.float    "column_23"
    t.float    "column_24"
    t.float    "column_25"
    t.float    "column_26"
    t.float    "column_27"
    t.float    "column_28"
    t.float    "column_29"
    t.float    "column_30"
    t.float    "column_31"
    t.float    "column_32"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "s"
    t.string   "x"
    t.string   "l"
    t.string   "w"
  end

  add_index "entities", ["l"], name: "index_entities_on_l", using: :btree
  add_index "entities", ["s", "x", "l", "w"], name: "index_entities_on_s_and_x_and_l_and_w", using: :btree
  add_index "entities", ["s"], name: "index_entities_on_s", using: :btree
  add_index "entities", ["w"], name: "index_entities_on_w", using: :btree
  add_index "entities", ["x"], name: "index_entities_on_x", using: :btree

end
