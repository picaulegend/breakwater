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

ActiveRecord::Schema.define(version: 2020_02_09_150421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "farms", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_farms_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "amount_in_stock"
    t.bigint "store_id"
    t.index ["store_id"], name: "index_items_on_store_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.decimal "value"
    t.decimal "nutrition"
    t.decimal "health"
    t.decimal "longevity"
    t.decimal "size"
    t.string "produce_type"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "seeds", force: :cascade do |t|
    t.bigint "slot_id"
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "size"
    t.decimal "health"
    t.decimal "nutrition"
    t.decimal "toxicity"
    t.decimal "days_required"
    t.string "produce_type"
    t.decimal "longevity"
    t.decimal "value"
    t.bigint "item_id"
    t.index ["item_id"], name: "index_seeds_on_item_id"
    t.index ["slot_id"], name: "index_seeds_on_slot_id"
    t.index ["user_id"], name: "index_seeds_on_user_id"
  end

  create_table "slots", force: :cascade do |t|
    t.bigint "stack_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "health"
    t.decimal "nutrition"
    t.decimal "longevity"
    t.decimal "size"
    t.string "produce_type"
    t.decimal "days_required"
    t.decimal "day_of_seeding"
    t.string "name"
    t.index ["stack_id"], name: "index_slots_on_stack_id"
  end

  create_table "stacks", force: :cascade do |t|
    t.string "lighting"
    t.string "nutrition"
    t.bigint "farm_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["farm_id"], name: "index_stacks_on_farm_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "items_id"
    t.decimal "reputation"
    t.index ["items_id"], name: "index_stores_on_items_id"
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "days_played"
    t.decimal "money"
  end

  add_foreign_key "farms", "users"
  add_foreign_key "seeds", "items"
  add_foreign_key "seeds", "slots"
  add_foreign_key "stacks", "farms"
  add_foreign_key "stores", "items", column: "items_id"
  add_foreign_key "stores", "users"
end
