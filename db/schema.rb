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

ActiveRecord::Schema.define(version: 20170822110232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "findings", force: :cascade do |t|
    t.bigint "record_id"
    t.string "provider"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_id"], name: "index_findings_on_record_id"
  end

  create_table "records", force: :cascade do |t|
    t.integer "discogs_id"
    t.json "styles"
    t.json "genres"
    t.string "title"
    t.json "artists"
    t.json "labels"
    t.integer "year"
    t.string "thumb"
    t.json "images"
    t.string "discogs_uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "discogs_id"
    t.string "discogs_wantlist_url"
    t.string "discogs_username"
    t.string "discogs_avatar"
    t.string "discogs_uri"
    t.integer "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wants", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_id"], name: "index_wants_on_record_id"
    t.index ["user_id"], name: "index_wants_on_user_id"
  end

  add_foreign_key "findings", "records"
  add_foreign_key "wants", "records"
  add_foreign_key "wants", "users"
end
