class AddGeneColumnToAssignments < ActiveRecord::Migration
  def self.up
    add_column :assignments, :gene_id, :integer
    add_index  :assignments, :gene_id
  end

  def self.down
    remove_column :assignments, :gene_id
  end
end
