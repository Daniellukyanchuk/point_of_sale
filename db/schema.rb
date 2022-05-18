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

ActiveRecord::Schema.define(version: 2022_04_22_080838) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "category_products", force: :cascade do |t|
    t.bigint "product_category_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_category_id"], name: "index_category_products_on_product_category_id"
    t.index ["product_id"], name: "index_category_products_on_product_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "supply_id"
    t.integer "product_id"
    t.float "remaining_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "supply_product_id"
    t.integer "production_id"
    t.float "cost_per_unit"
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

  create_table "permissions", force: :cascade do |t|
    t.string "table"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "category_name"
    t.text "category_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "productions", force: :cascade do |t|
    t.string "recipe_name"
    t.float "production_quantity"
    t.float "production_total_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "recipe_id"
    t.float "recipe_cost"
    t.integer "production_yield"
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name"
    t.float "price"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "grams_per_unit"
  end

  create_table "purchase_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "supply_id"
    t.float "purchase_quantity"
    t.float "purchase_price"
    t.float "purchase_subtotal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "estimated_quantity"
    t.float "estimated_cost"
    t.float "estimated_subtotal"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "supplier_id"
    t.float "purchase_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "estimated_total"
    t.date "date_ordered"
    t.date "date_expected"
    t.date "date_received"
  end

  create_table "recipe_products", force: :cascade do |t|
    t.integer "product_id"
    t.float "amount"
    t.float "ingredient_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "recipe_id"
    t.float "cost_per_kg"
  end

  create_table "recipes", force: :cascade do |t|
    t.float "recipe_cost"
    t.integer "yield"
    t.text "instructions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
    t.string "units"
    t.string "recipe_name"
  end

  create_table "role_permissions", force: :cascade do |t|
    t.integer "role_id"
    t.integer "permission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string "company_name"
    t.string "company_address"
    t.string "company_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "supplier_name"
    t.string "address"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
