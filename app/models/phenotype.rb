class Phenotype < ActiveRecord::Base
  has_and_belongs_to_many :genes, :join_table => :observations, :uniq => true
  has_and_belongs_to_many :phenologs, :uniq => true

  after_save :update_genes_counter_cache

  def update_genes_counter_cache
    self.genes.each { |c| c.update_count(self) } unless self.genes.empty?
  end

  def update_count
    update_attribute(:genes_count, self.genes.count)
  end
end
