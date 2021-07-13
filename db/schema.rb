# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_13_210339) do

  create_table "adoptions", force: :cascade do |t|
    t.string "date"
    t.integer "price"
    t.integer "animal_id"
    t.integer "visitor_id"
  end

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "breed"
    t.integer "shelter_id"
    t.string "species"
    t.boolean "adopted"
  end

  create_table "locations", force: :cascade do |t|
    t.integer "zip_code"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "name"
    t.integer "location_id"
  end

  create_table "visitors", force: :cascade do |t|
    t.string "name"
    t.integer "location_id"
    t.string "password"
  end

end
