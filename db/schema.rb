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

ActiveRecord::Schema.define(version: 20140603230301) do

  create_table "emails", force: true do |t|
    t.string   "address",                                null: false
    t.boolean  "confirmed",              default: false
    t.string   "confirmation_key"
    t.datetime "confirmation_send_date"
    t.datetime "confirmation_date"
    t.integer  "confirmation_attempts"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "base_address",           default: "",    null: false
    t.string   "public_id",              default: "",    null: false
  end

end
