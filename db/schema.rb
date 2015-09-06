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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140824135507) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "surname"
    t.string   "pymeName"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "credit_lines", :force => true do |t|
    t.string   "name"
    t.float    "interest_rate"
    t.integer  "admin_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "credit_lines", ["admin_id"], :name => "index_credit_lines_on_admin_id"

  create_table "payment_plans", :force => true do |t|
    t.string   "identification"
    t.datetime "birthDate"
    t.float    "principal"
    t.integer  "numberOfPayments"
    t.string   "state"
    t.float    "riskLevel"
    t.integer  "CreditLine_id"
    t.integer  "admin_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "payment_plans", ["CreditLine_id"], :name => "index_payment_plans_on_CreditLine_id"
  add_index "payment_plans", ["admin_id"], :name => "index_payment_plans_on_admin_id"

  create_table "payments", :force => true do |t|
    t.integer  "paymentNumber"
    t.float    "paymentInterest"
    t.float    "paymentAmortization"
    t.float    "pendingBalance"
    t.float    "totalPayment"
    t.integer  "payment_plan_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "payments", ["payment_plan_id"], :name => "index_payments_on_payment_plan_id"

end
