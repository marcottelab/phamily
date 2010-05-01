class CreateObservations < ActiveRecord::Migration
  def self.up
    create_table :observations do |t|
      t.references :gene
      t.references :phenotype
    end

    add_index :observations, [:gene_id,:phenotype_id], :unique => true
  end

  def self.down
    drop_table :observations
  end
end
