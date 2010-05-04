class Phenotype < ActiveRecord::Base
  SPECIES = ["xx", "Hs", "Mm", "Ce", "Sc", "At", "Dm", "Os"] # for _from_phenologdb stuff

  has_many :observations
  has_many :genes, :through => :observations
  has_many :phenolog_associations
  has_many :phenologs, :through => :phenolog_associations

  def update_count
    update_attribute(:genes_count, self.genes.count)
  end

  def self.create_from_phenologdb dbh, id
    sth = dbh.prepare("SELECT p.id, p.long_desc, p.species_id FROM phenotypes p WHERE p.id = #{id} LIMIT 1")
    sth.execute
    if row = sth.fetch
      phenotype = Phenotype.create!(:column_id => row[0], :desc => row[1], :species => SPECIES[row[2]])
    else
      nil
    end
  end
end
