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

ActiveRecord::Schema.define(:version => 20091228015848) do

  create_table "automobiles", :force => true do |t|
    t.float    "urbanity"
    t.float    "weekly_distance_estimate"
    t.float    "weekly_cost_estimate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boats", :force => true do |t|
    t.float    "weekly_distance_estimate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "weight"
    t.float    "displacement"
  end

  create_table "candies", :force => true do |t|
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
