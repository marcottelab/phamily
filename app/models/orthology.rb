class Orthology < ActiveRecord::Base
  belongs_to :orthogroup
  belongs_to :gene

  # Does not throw an error if creation fails because no guarantee the gene will
  # exist.
  def self.find_or_create_from_inparanoid orthogroup, gene, confidence
    orthology = Orthology.find_by_orthogroup_id_and_gene_id(orthogroup.id, gene.id)
    orthology = Orthology.create!(:orthogroup_id => orthogroup.id, :gene_id => gene.id, :confidence => confidence) if orthology.nil?
    orthology
  end
end
