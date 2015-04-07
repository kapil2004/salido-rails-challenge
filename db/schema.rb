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

ActiveRecord::Schema.define(version: 20150404132114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appellations", force: :cascade do |t|
    t.integer  "winedotcom_id"
    t.string   "name"
    t.string   "url"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appellations", ["region_id"], name: "index_appellations_on_region_id", using: :btree
  add_index "appellations", ["winedotcom_id"], name: "index_appellations_on_winedotcom_id", using: :btree

  create_table "labels", force: :cascade do |t|
    t.string   "winedotcom_id"
    t.string   "name"
    t.string   "url"
    t.integer  "wine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labels", ["wine_id"], name: "index_labels_on_wine_id", using: :btree
  add_index "labels", ["winedotcom_id"], name: "index_labels_on_winedotcom_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.integer  "winedotcom_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["winedotcom_id"], name: "index_regions_on_winedotcom_id", using: :btree

  create_table "traits", force: :cascade do |t|
    t.integer  "winedotcom_id"
    t.string   "name"
    t.string   "url"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "traits", ["winedotcom_id"], name: "index_traits_on_winedotcom_id", using: :btree

  create_table "varietals", force: :cascade do |t|
    t.integer  "winedotcom_id"
    t.string   "name"
    t.string   "url"
    t.integer  "wine_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "varietals", ["wine_type_id"], name: "index_varietals_on_wine_type_id", using: :btree
  add_index "varietals", ["winedotcom_id"], name: "index_varietals_on_winedotcom_id", using: :btree

  create_table "vineyards", force: :cascade do |t|
    t.integer  "winedotcom_id"
    t.string   "name"
    t.string   "url"
    t.string   "image_url"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "geo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vineyards", ["winedotcom_id"], name: "index_vineyards_on_winedotcom_id", using: :btree

  create_table "wine_traits", force: :cascade do |t|
    t.integer  "wine_id"
    t.integer  "trait_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wine_traits", ["trait_id"], name: "index_wine_traits_on_trait_id", using: :btree
  add_index "wine_traits", ["wine_id"], name: "index_wine_traits_on_wine_id", using: :btree

  create_table "wine_types", force: :cascade do |t|
    t.integer  "winedotcom_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wine_types", ["winedotcom_id"], name: "index_wine_types_on_winedotcom_id", using: :btree

  create_table "wines", force: :cascade do |t|
    t.integer  "winedotcom_id"
    t.string   "name"
    t.string   "url"
    t.string   "vintage"
    t.decimal  "price_max",      precision: 10, scale: 2
    t.decimal  "price_min",      precision: 10, scale: 2
    t.decimal  "price_retail",   precision: 10, scale: 2
    t.text     "description"
    t.decimal  "highest_score"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "geo_url"
    t.integer  "appellation_id"
    t.integer  "varietal_id"
    t.integer  "vineyard_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wines", ["appellation_id"], name: "index_wines_on_appellation_id", using: :btree
  add_index "wines", ["varietal_id"], name: "index_wines_on_varietal_id", using: :btree
  add_index "wines", ["vineyard_id"], name: "index_wines_on_vineyard_id", using: :btree
  add_index "wines", ["winedotcom_id"], name: "index_wines_on_winedotcom_id", using: :btree

  add_foreign_key "appellations", "regions"
  add_foreign_key "labels", "wines"
  add_foreign_key "varietals", "wine_types"
  add_foreign_key "wine_traits", "traits"
  add_foreign_key "wine_traits", "wines"
  add_foreign_key "wines", "appellations"
  add_foreign_key "wines", "varietals"
  add_foreign_key "wines", "vineyards"
end
