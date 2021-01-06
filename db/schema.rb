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

ActiveRecord::Schema.define(version: 2021_01_05_210834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "c_accounts", force: :cascade do |t|
    t.string "currency"
    t.float "balance"
    t.float "hold"
    t.string "available"
    t.string "float"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "c_orders", force: :cascade do |t|
    t.float "price"
    t.integer "size"
    t.string "side"
    t.string "product_id"
    t.string "time_in_force"
    t.date "expire_time"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "c_products", force: :cascade do |t|
    t.string "crypto"
    t.float "price"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
