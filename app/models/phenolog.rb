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
end
