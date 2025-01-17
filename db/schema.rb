# typed: false
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

ActiveRecord::Schema.define(version: 2019_05_05_175338) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.datetime "time"
    t.string "location"
    t.string "url"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "meetup_id"
  end

  create_table "invites", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "code"
    t.datetime "expiry"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
  end

  create_table "opportunities", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.string "company"
    t.string "contact"
    t.string "email"
    t.boolean "paid_position"
    t.text "content"
    t.datetime "good_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "code"
    t.string "remember_digest"
  end

  create_table "videos", force: :cascade do |t|
    t.string "video_url"
    t.string "slides_url"
    t.string "speaker_url"
    t.date "recorded_at"
    t.string "title"
    t.string "speaker"
    t.text "summary"
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "runtime"
    t.string "content_url"
  end

end
