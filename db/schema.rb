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

ActiveRecord::Schema.define(version: 20141128122036) do

  create_table "api_keys", force: true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_lines", force: true do |t|
    t.integer  "quantity",   default: 0
    t.decimal  "net_price"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_lines", ["order_id"], name: "index_item_lines_on_order_id"

  create_table "orders", force: true do |t|
    t.integer  "state"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "vat",        precision: 8, scale: 2, default: 20.0
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "products", force: true do |t|
    t.string   "name"
    t.decimal  "net_price",    precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_line_id"
  end

  add_index "products", ["item_line_id"], name: "index_products_on_item_line_id"

  create_table "status_transitions", force: true do |t|
    t.string   "event"
    t.string   "from"
    t.string   "to"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "status_transitions", ["order_id"], name: "index_status_transitions_on_order_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
