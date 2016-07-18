# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160718024319) do

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "scheduling_block_id"
    t.integer  "company_id"
    t.integer  "investor_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "ranking_id"
  end

  add_index "matches", ["company_id"], name: "index_matches_on_company_id"
  add_index "matches", ["investor_id"], name: "index_matches_on_investor_id"
  add_index "matches", ["ranking_id"], name: "index_matches_on_ranking_id"
  add_index "matches", ["scheduling_block_id"], name: "index_matches_on_scheduling_block_id"

  create_table "rankings", force: :cascade do |t|
    t.integer  "rankee_id"
    t.string   "rankee_type"
    t.integer  "ranker_id"
    t.string   "ranker_type"
    t.integer  "score"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "rankings", ["rankee_type", "rankee_id"], name: "index_rankings_on_rankee_type_and_rankee_id"
  add_index "rankings", ["ranker_type", "ranker_id"], name: "index_rankings_on_ranker_type_and_ranker_id"

  create_table "scheduling_blocks", force: :cascade do |t|
    t.string   "start_time"
    t.boolean  "bookable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
