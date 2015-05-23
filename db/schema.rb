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

ActiveRecord::Schema.define(version: 20150523172314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "heroku_api_key"
    t.string   "app_name"
  end

  create_table "boards_owners", force: :cascade do |t|
    t.integer "user_id"
    t.integer "board_id"
  end

  add_index "boards_owners", ["board_id"], name: "index_boards_owners_on_board_id", using: :btree
  add_index "boards_owners", ["user_id"], name: "index_boards_owners_on_user_id", using: :btree

  create_table "boards_subscriptions", force: :cascade do |t|
    t.integer "board_id"
    t.integer "user_id"
  end

  add_index "boards_subscriptions", ["board_id"], name: "index_boards_subscriptions_on_board_id", using: :btree
  add_index "boards_subscriptions", ["user_id"], name: "index_boards_subscriptions_on_user_id", using: :btree

  create_table "cards", force: :cascade do |t|
    t.string   "title"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.boolean  "archived",    default: false
    t.string   "preview_url"
    t.boolean  "previewing"
    t.string   "branch_name"
    t.text     "description"
  end

  add_index "cards", ["list_id"], name: "index_cards_on_list_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["card_id"], name: "index_comments_on_card_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "lists", force: :cascade do |t|
    t.string   "title"
    t.integer  "position"
    t.integer  "board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lists", ["board_id"], name: "index_lists_on_board_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password"
    t.string   "avatar_url"
    t.string   "auth_provider"
    t.string   "auth_uid"
    t.string   "nickname"
    t.string   "auth_token"
  end

end
