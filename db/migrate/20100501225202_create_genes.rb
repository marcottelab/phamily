class CreateGenes < ActiveRecord::Migration
  def self.up
    create_table :genes do |t|
      t.string :original_id, :limit => 20, :unique => true
      t.string :species, :limit => 3
      t.string :symbol, :limit => 20
      t.integer :phenotypes_count, :default => 0
    end
    add_index :genes, [:original_id, :species], :unique => true
    add_index :genes, :symbol
  end

  def self.down
    drop_table :genes
  end
end
