class SimilarityTable < Hash

  def initialize phenolog
    super # Initialize hash

    to_phenotype = phenolog.phenotypes[0]
    from_phenotype = phenolog.phenotypes[1]

    to_genes   = to_phenotype.genes
    from_genes = from_phenotype.genes

    g_dv = {}
    h_dv = {}

    to_genes.each do |g|
      g_to_dv = g.to_dv
      g_dv[g.original_id] = g_to_dv unless g_to_dv.empty?
    end

    from_genes.each do |h|
      h_to_dv = h.to_dv
      h_dv[h.original_id] = h_to_dv unless h_to_dv.empty?
    end

    g_dv.keys.each do |gid|
      gdv = g_dv[gid]

      h_dv.keys.each do |hid|
        hdv = h_dv[hid]
        sim = gdv.similarity(hdv)
        ortho = query_orthology(gid, hid)
        super["#{gid}-#{hid}"] = [sim, ortho]
      end
    end
  end

  def get_pair to_gene_original_id, from_gene_original_id
    self["#{to_gene_original_id}-#{from_gene_original_id}"]
  end
  
  def similarity to_gene_original_id, from_gene_original_id
    get_pair(to_gene_original_id, from_gene_original_id)[0]
  end
  
  alias :get_similarity :similarity

  def orthology? to_gene_original_id, from_gene_original_id
    get_pair(to_gene_original_id, from_gene_original_id)[1]
  end

  def has_pair?(to_gene_original_id, from_gene_original_id)
    self.has_key?("#{to_gene_original_id}-#{from_gene_original_id}")
  end
  
  alias :has_similarity? :has_pair?

  def write matrix_filename
    f = File.new(matrix_filename, "w")

    self.keys.sort.each do |key|
      line = key.split "-"
      line << self.similarity(line[0],line[1])
      f.puts line.join("\t")
    end

    f.close
    size
  end

  def to_genes
    @to_genes ||= self.keys.collect{|k| k.split("-")[0]}.uniq
  end

  def from_genes
    @from_genes ||= self.keys.collect{|k| k.split("-")[1]}.uniq
  end

protected
  def query_orthology g1, g2
    ActiveRecord::Base.connection.select_all(<<SQL
SELECT
    g1.original_id AS g1_oid,
    g2.original_id AS g2_oid,
    o1.orthogroup_id
  FROM genes g1
  INNER JOIN orthologies o1 ON (o1.gene_id = g1.id)
  INNER JOIN orthologies o2 ON (o2.orthogroup_id = o1.orthogroup_id)
  INNER JOIN genes g2 ON (o2.gene_id = g2.id)
  WHERE g1.species != g2.species
    AND g1.original_id = '#{g1}'
    AND g2.original_id = '#{g2}';
SQL
      ).size > 0 ? true : false
  end
end