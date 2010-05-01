class CreatePhenotypes < ActiveRecord::Migration
  def self.up
    create_table :phenotypes do |t|
      t.string :species, :limit => 3
      t.string :original_id, :limit => 20, :unique => true
      t.text :desc
      t.integer :genes_count, :default => 0
    end

    add_column :phenotypes, :phenologdb_id, :unique => true
    add_column :phenotypes, :species
  end

  def self.down
    drop_table :phenotypes
  end
end
