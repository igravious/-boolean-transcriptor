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

ActiveRecord::Schema.define(version: 20140526203006) do

  create_table "headings", force: true do |t|
    t.string   "index_term", null: false
    t.string   "type",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "headings", ["index_term"], name: "index_headings_on_index_term", unique: true

  create_table "items", force: true do |t|
    t.integer  "division"
    t.string   "description"
    t.integer  "folios"
    t.integer  "pp"
    t.date     "item_date"
    t.integer  "penner"
    t.string   "fa_seq"
    t.string   "fa_structure"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year"
    t.string   "size"
    t.string   "commentary"
    t.date     "also"
    t.date     "range"
    t.string   "month"
    t.string   "pp_extra"
    t.integer  "sub"
  end

  add_index "items", ["fa_seq", "fa_structure"], name: "index_items_on_fa_seq_and_fa_structure", unique: true

  create_table "locators", force: true do |t|
    t.integer  "heading_id"
    t.integer  "scan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content"
  end

  add_index "locators", ["scan_id", "heading_id", "content"], name: "index_locators_on_scan_id_and_heading_id_and_content", unique: true

  create_table "members", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.integer  "scans_accepted",         default: 0
    t.string   "nick"
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true
  add_index "members", ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true

  create_table "notes", force: true do |t|
    t.integer  "type"
    t.binary   "bytes"
    t.integer  "item_id"
    t.integer  "scan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "member_id"
  end

  create_table "scans", force: true do |t|
    t.string   "stringified"
    t.string   "file_name"
    t.integer  "institution"
    t.string   "prefix"
    t.integer  "major_seq"
    t.integer  "seq"
    t.integer  "minor_seq"
    t.integer  "item_id"
    t.integer  "state"
    t.text     "transcription"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.binary   "image_data"
    t.string   "directory"
  end

  add_index "scans", ["item_id"], name: "index_scans_on_item_id"

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
