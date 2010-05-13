class CreateOrthologies < ActiveRecord::Migration
  def self.up
    create_table :orthologies do |t|
      t.references :orthogroup
      t.references :gene
      t.decimal :confidence, :precision => 4, :scale => 3
    end

    add_index :orthologies, [:gene_id, :orthogroup_id], :unique => true
  end

  def self.down
    drop_table :orthologies
  end
end
