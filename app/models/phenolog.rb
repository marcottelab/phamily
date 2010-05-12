class Phenolog < ActiveRecord::Base
  has_many :phenolog_associations
  has_many :phenotypes, :through => :phenolog_associations

  def genes
    g = Set.new
    phenotypes.each do |p|
      g.merge p.genes.find(:all, :include => :assignments)
    end
    g.to_a
  end

  def other_phenotype(id)
    phenotypes.each do |phenotype|
      return phenotype if phenotype.id != id
    end
  end


  def genes_by_assignment options = {}
    @genes_by_assignment ||= genes_by_assignment_internal(options)
  end
  

  def orthologs_by_assignment options = {}
    outer_h = genes_by_assignment options

    orthologs_outer_h = {}

    outer_h.each_pair do |k,species_h|
      orthologs_outer_h[k] = species_h if species_h.size >= 2
    end

    orthologs_outer_h
  end

  def to_sim
    SimilarityTable.new(self)
  end

protected
  # Returns a hash with keys = assignments, value = second hash.
  # The second hash is from species to list of genes.
  def genes_by_assignment_internal options = {}
    opts = {
      :max_evalue => 1
    }
    outer_h = {}
    genes.each do |gene|
      gene.assignments.each do |assignment|

        next if assignment.e_value > opts[:max_evalue]

        outer_h[assignment.superfamily_desc] = Hash.new{|h,k| h[k] = []} unless outer_h.has_key?(assignment.superfamily_desc)
        outer_h[assignment.superfamily_desc][gene.species] << gene
      end
    end

    outer_h.each_pair do |k,species_h|
      species_h.each_pair do |species,genes|
        outer_h[k][species] = genes.uniq
      end
    end

    outer_h
  end
end
