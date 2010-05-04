class Phenolog < ActiveRecord::Base
  has_many :phenolog_associations
  has_many :phenotypes, :through => :phenolog_associations

  def genes
    g = Set.new
    phenotypes.each do |p|
      g.merge p.genes
    end
    g.to_a
  end
end
