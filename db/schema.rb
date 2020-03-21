# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_21_100049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.string "body", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_messages_on_player_id"
    t.index ["room_id"], name: "index_messages_on_room_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "username"
    t.bigint "room_id", null: false
    t.boolean "ready", default: false
    t.string "punchline"
    t.integer "score", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "online", default: false
    t.index ["room_id"], name: "index_players_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "song_id"
    t.boolean "playing", default: false
    t.boolean "started", default: false
    t.bigint "dealer_id"
    t.index ["dealer_id"], name: "index_rooms_on_dealer_id"
  end

  add_foreign_key "messages", "players"
  add_foreign_key "messages", "rooms"
  add_foreign_key "players", "rooms"
end
