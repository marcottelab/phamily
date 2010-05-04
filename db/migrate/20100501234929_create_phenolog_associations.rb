class CreatePhenologAssociations < ActiveRecord::Migration
  def self.up
    create_table :phenolog_associations do |t|
      t.references :phenolog
      t.references :phenotype
    end

    add_index :phenolog_associations, [:phenotype_id,:phenolog_id], :unique => true
  end

  def self.down
    drop_table :phenologs_phenotypes
  end
end
