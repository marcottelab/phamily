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

ActiveRecord::Schema.define(:version => 20100429234353) do

  create_table "assignments", :force => true do |t|
    t.string   "species"
    t.string   "original_id"
    t.string   "row_id"
    t.integer  "model_id"
    t.string   "region"
    t.decimal  "e_value"
    t.integer  "superfamily_id"
    t.string   "superfamily_desc"
    t.decimal  "family_e_value"
    t.integer  "family_id"
    t.string   "family_desc"
    t.string   "most_similar_structure"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["family_id"], :name => "index_assignments_on_family_id"
  add_index "assignments", ["model_id"], :name => "index_assignments_on_model_id"
  add_index "assignments", ["original_id", "species"], :name => "index_assignments_on_original_id_and_species"
  add_index "assignments", ["row_id", "species"], :name => "index_assignments_on_row_id_and_species"
  add_index "assignments", ["superfamily_id"], :name => "index_assignments_on_superfamily_id"

end
