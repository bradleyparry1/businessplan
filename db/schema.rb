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

ActiveRecord::Schema.define(version: 20180428202322) do

  create_table "accounts", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "major"
    t.string "minor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "actuals", force: :cascade do |t|
    t.integer "team_id"
    t.integer "account_id"
    t.text "description"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "po_number"
    t.integer "month"
  end

  create_table "base_others", force: :cascade do |t|
    t.string "description"
    t.integer "team_id"
    t.integer "account_id"
    t.string "supplier"
    t.string "po_number"
    t.float "apr"
    t.float "may"
    t.float "jun"
    t.float "jul"
    t.float "aug"
    t.float "sep"
    t.float "oct"
    t.float "nov"
    t.float "dec"
    t.float "jan"
    t.float "feb"
    t.float "mar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "base_people", force: :cascade do |t|
    t.integer "name_id"
    t.integer "team_id"
    t.date "start"
    t.date "end"
    t.float "fte"
    t.boolean "brexit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "communities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "frameworks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grades", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.string "pcc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "names", force: :cascade do |t|
    t.string "name"
    t.string "staff_number"
    t.string "job_title"
    t.integer "role_id"
    t.integer "community_id"
    t.integer "grade_id"
    t.integer "profession_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "framework_id"
    t.integer "status_id"
    t.float "charge_rate"
  end

  create_table "ochanges", force: :cascade do |t|
    t.string "description"
    t.integer "team_id"
    t.integer "account_id"
    t.string "supplier"
    t.string "po_number"
    t.float "apr", default: 0.0
    t.float "may", default: 0.0
    t.float "jun", default: 0.0
    t.float "jul", default: 0.0
    t.float "aug", default: 0.0
    t.float "sep", default: 0.0
    t.float "oct", default: 0.0
    t.float "nov", default: 0.0
    t.float "dec", default: 0.0
    t.float "jan", default: 0.0
    t.float "feb", default: 0.0
    t.float "mar", default: 0.0
    t.integer "other_id"
    t.boolean "bmo_approved"
    t.boolean "central_approved"
    t.boolean "central_declined"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "for_deletion"
    t.text "comment"
  end

  create_table "others", force: :cascade do |t|
    t.string "description"
    t.integer "team_id"
    t.integer "account_id"
    t.string "supplier"
    t.string "po_number"
    t.float "apr", default: 0.0
    t.float "may", default: 0.0
    t.float "jun", default: 0.0
    t.float "jul", default: 0.0
    t.float "aug", default: 0.0
    t.float "sep", default: 0.0
    t.float "oct", default: 0.0
    t.float "nov", default: 0.0
    t.float "dec", default: 0.0
    t.float "jan", default: 0.0
    t.float "feb", default: 0.0
    t.float "mar", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pchanges", force: :cascade do |t|
    t.integer "person_id"
    t.integer "team_id"
    t.date "start"
    t.date "end"
    t.float "fte"
    t.boolean "brexit"
    t.boolean "bmo_approved"
    t.boolean "central_approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "name_id"
    t.boolean "for_deletion"
    t.integer "user_id"
    t.text "comment"
    t.boolean "central_declined"
  end

  create_table "people", force: :cascade do |t|
    t.integer "name_id"
    t.integer "team_id"
    t.date "start"
    t.date "end"
    t.float "fte"
    t.boolean "brexit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "professions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "programmes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rates", force: :cascade do |t|
    t.integer "group_id"
    t.integer "grade_id"
    t.float "salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "cc"
    t.integer "group_id"
    t.integer "programme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "user_type"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 1073741823
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
