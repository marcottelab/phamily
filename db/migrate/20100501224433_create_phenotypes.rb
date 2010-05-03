class CreatePhenotypes < ActiveRecord::Migration
  def self.up
    create_table :phenotypes do |t|
      t.string :species, :limit => 3
      t.string :original_id, :limit => 20, :unique => true
      t.text :desc
      t.integer :genes_count, :default => 0
      t.integer :column_id, :unique => true
    end

    add_index :phenotypes, :original_id, :unique => true
    add_index :phenotypes, :species
    add_index :phenotypes, :column_id, :unique => true
  end

  def self.down
    drop_table :phenotypes
  end
end
