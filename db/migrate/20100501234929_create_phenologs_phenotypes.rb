class CreatePhenologsPhenotypes < ActiveRecord::Migration
  def self.up
    create_table :phenologs_phenotypes do |t|
      t.references :phenolog
      t.references :phenotype
    end

    add_index :phenologs_phenotypes, [:phenotype_id,:phenolog_id], :unique => true
  end

  def self.down
    drop_table :phenologs_phenotypes
  end
end
