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

ActiveRecord::Schema.define(:version => 20100501234929) do

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

  create_table "genes", :force => true do |t|
    t.string  "original_id",      :limit => 20
    t.string  "species",          :limit => 3
    t.string  "symbol",           :limit => 20
    t.integer "phenotypes_count",               :default => 0
  end

  add_index "genes", ["original_id", "species"], :name => "index_genes_on_original_id_and_species", :unique => true
  add_index "genes", ["symbol"], :name => "index_genes_on_symbol"

  create_table "observations", :force => true do |t|
    t.integer "gene_id"
    t.integer "phenotype_id"
  end

  add_index "observations", ["gene_id", "phenotype_id"], :name => "index_observations_on_gene_id_and_phenotype_id", :unique => true

  create_table "phenologs", :force => true do |t|
    t.decimal "distance"
    t.decimal "ppv",                       :precision => 4, :scale => 3
    t.string  "species_pair", :limit => 6
    t.boolean "confirmed",                                               :default => false
    t.integer "overlap"
  end

  create_table "phenologs_phenotypes", :force => true do |t|
    t.integer "phenolog_id"
    t.integer "phenotype_id"
  end

  add_index "phenologs_phenotypes", ["phenotype_id", "phenolog_id"], :name => "index_phenologs_phenotypes_on_phenotype_id_and_phenolog_id", :unique => true

  create_table "phenotypes", :force => true do |t|
    t.string  "species",     :limit => 3
    t.string  "original_id", :limit => 20
    t.text    "desc"
    t.integer "genes_count",               :default => 0
    t.integer "column_id"
  end

  add_index "phenotypes", ["original_id"], :name => "index_phenotypes_on_original_id", :unique => true
  add_index "phenotypes", ["species"], :name => "index_phenotypes_on_species"

end
