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

ActiveRecord::Schema.define(version: 2021_12_22_100147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "product_id"
    t.date "date"
    t.integer "amount"
    t.decimal "price_per_unit"
    t.decimal "costs"
    t.decimal "current_amount_left"
    t.decimal "value_of_item"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "purchase_product_id"
    t.decimal "amount_purchased_in_grams"
    t.decimal "amount_left_in_grams"
  end

  create_table "order_products", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "quantity"
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

  create_table "production_recipes", force: :cascade do |t|
    t.integer "production_id"
    t.integer "product_id"
    t.integer "recipe_id"
    t.decimal "product_amount"
    t.decimal "recipe_price"
    t.decimal "product_subtotal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "productions", force: :cascade do |t|
    t.integer "recipe_id"
    t.string "recipe_name"
    t.decimal "grand_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name"
    t.float "price"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "weight_per_product_unit_grams"
  end

  create_table "purchase_products", force: :cascade do |t|
    t.integer "purchase_id"
    t.integer "product_id"
    t.decimal "estimated_quantity"
    t.decimal "actual_quantity"
    t.decimal "estimated_price_per_unit"
    t.decimal "actual_price_per_unit"
    t.decimal "estimated_subtotal"
    t.decimal "actual_subtotal"
    t.decimal "estimated_quantity_in_grams"
    t.decimal "actual_quantity_in_grams"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "supplier_id"
    t.date "date_of_the_order"
    t.date "expected_date_of_delivery"
    t.decimal "estimated_total"
    t.decimal "actual_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipe_products", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "product_id"
    t.decimal "product_amount"
    t.decimal "product_price"
    t.decimal "product_subtotal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "recipe_name"
    t.string "cooking_instructions"
    t.decimal "grand_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "suppliers_name"
    t.string "city"
    t.string "country"
    t.string "address"
    t.integer "supply_product_id"
    t.bigint "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
