# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_02_21_220310) do
  create_table "clip_view_counts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "clip_id", null: false
    t.integer "view_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clip_id"], name: "index_clip_view_counts_on_clip_id"
  end

  create_table "clips", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "broadcaster_id"
    t.integer "creator_id"
    t.integer "game_id"
    t.string "language"
    t.string "title"
    t.datetime "clip_created_at"
    t.string "thumbnail_url"
    t.float "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", id: :bigint, default: nil, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "box_art_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlists", id: :bigint, default: nil, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "creator_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "twitch_users", id: :bigint, default: nil, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "profile_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "clip_view_counts", "clips"
end
