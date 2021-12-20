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

ActiveRecord::Schema.define(version: 2021_12_20_214059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventory_records", force: :cascade do |t|
    t.integer "supply_id"
    t.integer "product_id"
    t.float "remaining_quantity"
    t.date "date_added"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
    t.float "quantity"
    t.float "sale_price"
    t.float "subtotal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "client_id"
    t.float "grand_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name"
    t.float "price"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "inventory"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "supplier_name"
    t.string "address"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplies", force: :cascade do |t|
    t.integer "supplier_id"
    t.float "purchase_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "estimated_total"
    t.date "date_ordered"
    t.date "date_expected"
    t.date "date_received"
  end

  create_table "supply_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "supply_id"
    t.float "purchase_quantity"
    t.float "purchase_price"
    t.float "purchase_subtotal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "remaining_quantity"
    t.float "estimated_quantity"
    t.float "estimated_cost"
    t.float "estimated_subtotal"
  end

end
