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

ActiveRecord::Schema.define(version: 20170519151055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.string   "email"
    t.string   "alt_email"
    t.string   "phone"
    t.string   "title"
    t.text     "background"
    t.datetime "first_met"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "full_address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "lead_team"
    t.string   "auth_token"
    t.boolean  "active",       default: true
    t.index ["active"], name: "index_contacts_on_active", using: :btree
    t.index ["auth_token"], name: "index_contacts_on_auth_token", using: :btree
    t.index ["lead_team"], name: "index_contacts_on_lead_team", using: :btree
  end

  create_table "goals", force: :cascade do |t|
    t.text     "objective"
    t.integer  "contact_id"
    t.boolean  "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_goals_on_contact_id", using: :btree
    t.index ["objective"], name: "index_goals_on_objective", using: :btree
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.string   "subject"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "contact_id"
    t.string   "name"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.datetime "completed_at"
  end

  create_table "retrospectives", force: :cascade do |t|
    t.text     "what_has_gone_well"
    t.text     "what_has_gone_poorly"
    t.text     "how_are_your_goals"
    t.integer  "user_id"
    t.integer  "contact_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["contact_id"], name: "index_retrospectives_on_contact_id", using: :btree
    t.index ["user_id"], name: "index_retrospectives_on_user_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.integer  "tag_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tags_on_user_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "due"
    t.integer  "taskable_id"
    t.string   "taskable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "completed_at"
    t.integer  "project_id"
    t.string   "state"
    t.integer  "position"
    t.datetime "started_at"
    t.index ["position"], name: "index_tasks_on_position", using: :btree
    t.index ["taskable_type", "taskable_id"], name: "index_tasks_on_taskable_type_and_taskable_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "role"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
