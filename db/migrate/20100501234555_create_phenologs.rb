class CreatePhenologs < ActiveRecord::Migration
  def self.up
    create_table :phenologs do |t|
      t.decimal :distance
      t.decimal :ppv, :precision => 4, :scale => 3
      t.string :species_pair, :limit => 6
      t.boolean :confirmed, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :phenologs
  end
end
