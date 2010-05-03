class Phenotype < ActiveRecord::Base
  has_and_belongs_to_many :genes, :join_table => :observations, :uniq => true
  has_and_belongs_to_many :phenologs, :uniq => true

  def update_count
    update_attribute(:genes_count, self.genes.count)
  end
end
