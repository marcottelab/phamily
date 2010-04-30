class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.string :species
      t.string :original_id
      t.string :row_id
      t.integer :model_id
      t.string :region
      t.decimal :e_value
      t.integer :superfamily_id
      t.string :superfamily_desc
      t.decimal :family_e_value
      t.integer :family_id
      t.string :family_desc
      t.string :most_similar_structure

      t.timestamps
    end
    
    add_index :assignments, [:original_id, :species]
    add_index :assignments, [:row_id, :species]
    add_index :assignments, :model_id
    add_index :assignments, :superfamily_id
    add_index :assignments, :family_id
  end

  def self.down
    drop_table :assignments
  end
end
