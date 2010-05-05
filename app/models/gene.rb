class Gene < ActiveRecord::Base
  has_many :observations
  has_many :phenotypes, :through => :observations
  has_many :assignments

  def update_count
    update_attribute(:phenotypes_count, self.phenotypes.count)
  end

  # Get the gene's assigned superfamily_ids
  def superfamily_ids
    superfamily_ids_set.to_a
  end

  def superfamily_ids_set
    Set.new(self.assignments.collect { |a| a.superfamily_id })
  end

#  def self.find_or_create_from_phenologdb_by_phenotype_id dbh, local_phenotype
#    sth = dbh.prepare("SELECT DISTINCT g.unique_id FROM genes g INNER JOIN phenotype_observations po ON (g.id = po.gene_id) WHERE po.phenotype_id = #{local_phenotype.column_id}")
#    sth.execute
#    genes = []
#    while row = sth.fetch
#      gene = Gene.find(:first, :conditions => {:original_id => row[0]})
#      gene = Gene.create!(:original_id => row[0], :species => local_phenotype.species) if gene.nil?
#
#      unless gene.phenotype_ids.include?(local_phenotype.id)
#        gene.phenotype_ids << local_phenotype.id
#        gene.update_count
#      end
#
#      genes << gene
#    end
#
#    genes
#  end
end
