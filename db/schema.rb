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

ActiveRecord::Schema[8.0].define(version: 2025_11_08_172849) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "offices", force: :cascade do |t|
    t.string "name", null: false
    t.string "location", null: false
    t.text "contact_info", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "office_id", null: false
    t.text "package_description", null: false
    t.decimal "weight", precision: 10, scale: 2, null: false
    t.text "delivery_address", null: false
    t.integer "status", default: 0, null: false
    t.decimal "estimated_cost", precision: 10, scale: 2
    t.integer "estimated_time"
    t.string "tracking_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["office_id"], name: "index_orders_on_office_id"
    t.index ["status"], name: "index_orders_on_status"
    t.index ["tracking_code"], name: "index_orders_on_tracking_code", unique: true
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.text "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "orders", "offices"
  add_foreign_key "orders", "users"
end
