class CreateOrthogroups < ActiveRecord::Migration
  def self.up
    create_table :orthogroups do |t|
      t.integer :rank
      t.integer :score
      t.string :species_pair, :limit => 6

      t.timestamps
    end

    add_index :orthogroups, [:rank, :species_pair], :unique => true
  end

  def self.down
    drop_table :orthogroups
  end
end
