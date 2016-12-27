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

ActiveRecord::Schema.define(version: 20161227173358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sento_kanban_activities", force: :cascade do |t|
    t.integer  "board_id",    null: false
    t.integer  "column_id"
    t.integer  "card_id"
    t.integer  "author_id",   null: false
    t.string   "i18n_key",    null: false
    t.text     "i18n_values"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["author_id"], name: "index_sento_kanban_activities_on_author_id", using: :btree
    t.index ["board_id"], name: "index_sento_kanban_activities_on_board_id", using: :btree
  end

  create_table "sento_kanban_board_links", force: :cascade do |t|
    t.integer  "board_id",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id", "user_id"], name: "index_sento_kanban_board_links_on_board_id_and_user_id", unique: true, using: :btree
  end

  create_table "sento_kanban_boards", force: :cascade do |t|
    t.string   "title",       null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sento_kanban_cards", force: :cascade do |t|
    t.integer  "board_id",                    null: false
    t.integer  "column_id",                   null: false
    t.string   "title",                       null: false
    t.text     "description"
    t.integer  "card_order"
    t.boolean  "archived",    default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["archived"], name: "index_sento_kanban_cards_on_archived", using: :btree
    t.index ["board_id"], name: "index_sento_kanban_cards_on_board_id", using: :btree
    t.index ["column_id"], name: "index_sento_kanban_cards_on_column_id", using: :btree
  end

  create_table "sento_kanban_cards_users", force: :cascade do |t|
    t.integer  "card_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id", "user_id"], name: "index_sento_kanban_cards_users_on_card_id_and_user_id", unique: true, using: :btree
  end

  create_table "sento_kanban_columns", force: :cascade do |t|
    t.integer  "board_id",   null: false
    t.string   "name",       null: false
    t.integer  "position",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_sento_kanban_columns_on_board_id", using: :btree
  end

  create_table "sento_kanban_comments", force: :cascade do |t|
    t.integer  "board_id",   null: false
    t.integer  "card_id",    null: false
    t.integer  "author_id",  null: false
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_sento_kanban_comments_on_board_id", using: :btree
    t.index ["card_id"], name: "index_sento_kanban_comments_on_card_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string  "username"
    t.string  "fullname"
    t.string  "avatar"
    t.integer "current_board_id"
    t.boolean "virtual",          default: false, null: false
    t.index ["username"], name: "index_users_on_username", using: :btree
    t.index ["virtual"], name: "index_users_on_virtual", using: :btree
  end

end
