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

    g_dv.keys.sort.each do |gid|
      gdv = g_dv[gid]

      h_dv.keys.sort.each do |hid|
        hdv = h_dv[hid]
        super["#{gid}-#{hid}"] = gdv.similarity(hdv)
      end
    end
  end

  def get_pair to_gene_original_id, from_gene_original_id
    self["#{to_gene_original_id}-#{from_gene_original_id}"]
  end
  alias :get_similarity :get_pair

  def has_pair?(to_gene_original_id, from_gene_original_id)
    self.has_key?("#{to_gene_original_id}-#{from_gene_original_id}")
  end
  alias :has_similarity? :has_pair?

  def write matrix_filename
    f = File.new(matrix_filename, "w")

    self.keys.sort.each do |key|
      line = key.split "-"
      line << self.get_pair(line[0],line[1])
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
end