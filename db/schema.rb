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

ActiveRecord::Schema.define(version: 20141122075614) do

  create_table "distributed_documents", force: true do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.integer "document_id"
    t.text    "key"
  end

  create_table "documents", force: true do |t|
    t.text    "name"
    t.text    "path"
    t.text    "remark"
    t.integer "user_id"
    t.integer "key_id"
  end

  create_table "friendships", force: true do |t|
    t.integer "user_id"
    t.integer "friend_id"
  end

  create_table "friendships_users", force: true do |t|
    t.integer "user_id"
    t.integer "friend_id"
  end

  create_table "key_pairs", force: true do |t|
    t.text    "privat_key"
    t.text    "public_key"
    t.string  "remark"
    t.integer "user_id"
  end

  create_table "keys", force: true do |t|
    t.text    "value"
    t.text    "remark"
    t.integer "user_id"
  end

  create_table "loans", force: true do |t|
    t.integer "key_id"
    t.integer "user_id"
    t.integer "friend_id"
    t.text    "key_value"
    t.text    "remark"
  end

  create_table "users", force: true do |t|
    t.text    "email"
    t.text    "password"
    t.text    "name"
    t.text    "confirm_password"
    t.integer "user_id"
    t.text    "key_public"
    t.text    "key_private"
    t.text    "super_key"
    t.string  "password_hash"
  end

  add_index "users", ["user_id"], name: "index_users_on_user_id"

end
