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

ActiveRecord::Schema[8.1].define(version: 2026_03_19_162228) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer "amount_paid_cents"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.integer "group_size"
    t.string "last_name"
    t.bigint "package_id", null: false
    t.string "phone"
    t.text "special_requests"
    t.integer "status", default: 0
    t.string "stripe_session_id"
    t.date "tour_date"
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_bookings_on_package_id"
  end

  create_table "packages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "duration"
    t.string "name"
    t.integer "price_cents"
    t.string "slug"
    t.string "stripe_price_id"
    t.string "tagline"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bookings", "packages"
end
