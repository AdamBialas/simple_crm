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

ActiveRecord::Schema.define(version: 2022_04_21_174726) do

  create_table "addresses", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "street"
    t.string "number"
    t.string "city"
    t.string "region"
    t.string "postcode"
    t.integer "status"
    t.boolean "main"
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_addresses_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "last_action"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "note"
    t.boolean "own", default: false, null: false
    t.integer "user_id"
    t.string "features_hash"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.integer "company_id", null: false
    t.string "email"
    t.string "phone"
    t.datetime "last_event"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "jobposition"
    t.index ["company_id"], name: "index_contacts_on_company_id"
  end

  create_table "plans", force: :cascade do |t|
    t.date "event_date"
    t.string "event_name"
    t.text "event_description"
    t.integer "status"
    t.integer "event_type"
    t.integer "company_id"
    t.integer "user_id"
    t.integer "contact_id"
    t.integer "address_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "lastname"
    t.string "rights"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "companies"
  add_foreign_key "companies", "users"
  add_foreign_key "contacts", "companies"
end
