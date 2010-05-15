class Orthogroup < ActiveRecord::Base
  has_many :orthologies, :dependent => :destroy
  has_many :genes, :through => :orthologies


  # Very specific scope -- takes the best score and rank for each pair of genes,
  # attaching the important information for those genes. This is called by
  # rake prob:prior:sfsimilarity_given_orthology.
  named_scope :orthologs_by_species_pair, lambda { |s1,s2| {
      :select => "DISTINCT MIN(orthogroups.rank) AS rank, MAX(orthogroups.score) AS score, g1.id AS g_id, g2.id AS h_id, g1.original_id AS g_original_id, MAX(o1.confidence) AS g_confidence, g2.original_id AS h_original_id, MAX(o2.confidence) AS h_confidence",
      :conditions => ["g1.species = ? AND g2.species = ?", s1, s2],
      :group => "g_id, h_id, g_original_id, h_original_id",
      :joins  => <<JOINS
  INNER JOIN orthologies o1 ON (o1.orthogroup_id = orthogroups.id)
  INNER JOIN genes g1 ON (o1.gene_id = g1.id)
  INNER JOIN orthologies o2 ON (o2.orthogroup_id = orthogroups.id)
  INNER JOIN genes g2 ON (o2.gene_id = g2.id)
JOINS
}}

  # Needed for the load_orthologs rake task.
  def self.find_or_create! species_pair, rank, score
    params = {:species_pair => species_pair, :score => score, :rank => rank}
    orthogroup = Orthogroup.find(:first, :conditions => params)
    orthogroup = Orthogroup.create!(params) if orthogroup.nil?
    orthogroup
  end
end
