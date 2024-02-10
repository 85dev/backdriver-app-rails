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

ActiveRecord::Schema[7.0].define(version: 2024_01_27_174846) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "car_histories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "total_sold_cars_value"
    t.integer "cars_sold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_car_histories_on_user_id"
  end

  create_table "car_options", force: :cascade do |t|
    t.string "exterior_color"
    t.string "interior_color"
    t.string "motricity"
    t.string "gearbox"
    t.string "vehicle_type"
    t.string "model"
    t.integer "door_number"
    t.string "specifications"
    t.bigint "car_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "interior_material"
    t.string "exterior_material"
    t.index ["car_id"], name: "index_car_options_on_car_id"
  end

  create_table "cars", force: :cascade do |t|
    t.integer "model_year"
    t.date "release_date"
    t.string "fuel"
    t.string "vehicle_type"
    t.integer "fiscal_power"
    t.string "required_licence"
    t.integer "horse_power"
    t.integer "seats"
    t.date "acquisition_date"
    t.integer "owners_number"
    t.integer "mileage"
    t.integer "estimated_value"
    t.string "geolocalisation"
    t.boolean "to_sell"
    t.date "last_time_driven"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "model_specific_name"
    t.string "purchase_price"
    t.string "brand"
    t.string "numberplate"
    t.integer "selling_price"
    t.boolean "sold"
    t.string "interior_state"
    t.string "exterior_state"
    t.integer "drive_count_since_acquisition"
    t.integer "journey_taken"
    t.boolean "regularly_maintained"
    t.string "tires_state"
    t.string "country_of_acquisition"
    t.string "current_nationality"
    t.string "produced_for_country"
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "insurances", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.string "assurance_type"
    t.date "assured_until"
    t.integer "assurance_price"
    t.string "assurance_company"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_insurances_on_car_id"
  end

  create_table "journeys", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.datetime "date"
    t.float "mileage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_journeys_on_car_id"
  end

  create_table "maintainances", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.integer "maintainance_costs"
    t.boolean "maintainance_needed"
    t.boolean "accidented"
    t.string "repair_company"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "last_repair_date"
    t.string "repair_history"
    t.index ["car_id"], name: "index_maintainances_on_car_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "message"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "repairs", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.integer "repair_cost"
    t.string "repair_company"
    t.string "repair_topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_repairs_on_car_id"
  end

  create_table "technical_controls", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.integer "technical_control_frequency"
    t.decimal "technical_control_price"
    t.string "control_company"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "valid_until"
    t.index ["car_id"], name: "index_technical_controls_on_car_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "unlock_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "car_histories", "users"
  add_foreign_key "car_options", "cars"
  add_foreign_key "cars", "users"
  add_foreign_key "insurances", "cars"
  add_foreign_key "journeys", "cars"
  add_foreign_key "maintainances", "cars"
  add_foreign_key "notifications", "users"
  add_foreign_key "repairs", "cars"
  add_foreign_key "technical_controls", "cars"
end
