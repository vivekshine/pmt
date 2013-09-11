# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130905212017) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "adminlastname"
    t.string   "adminfirstname"
    t.string   "adminlogin"
    t.string   "email"
    t.string   "company"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "credits"
    t.boolean  "active"
    t.string   "coupon"
    t.string   "plainpwd"
    t.string   "association"
  end

  create_table "coupons", :force => true do |t|
    t.string   "code"
    t.string   "value"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "reference"
    t.string   "message"
    t.string   "action"
    t.text     "params"
    t.boolean  "test"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "description"
    t.string   "state",            :default => "pending"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "credits"
    t.string   "express_token"
    t.string   "express_payer_id"
  end

  create_table "purchases", :force => true do |t|
    t.string   "transaction_id"
    t.string   "cvv2_code"
    t.string   "avs_code"
    t.integer  "amount",         :limit => 10, :precision => 10, :scale => 0
    t.datetime "created_at"
    t.string   "token"
    t.datetime "updated_at"
    t.string   "number"
    t.integer  "company"
    t.string   "state"
    t.integer  "credits"
    t.integer  "coupon"
  end

  create_table "user_histories", :force => true do |t|
    t.integer  "userid"
    t.string   "module"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "company"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "credits"
    t.string   "username"
  end

end
