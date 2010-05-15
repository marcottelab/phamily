# Describe genes as documents with assignments as words.
# You create one DocHash for each gene, and it has an entry for each assignment.
class DocVector < Hash

  # Given no gene, initialize as representing the entire set of available assignments
  # and their frequencies.
  #
  # Given a gene, initialize as containing only the assignments in that gene (and
  # 0 for every other assignment.
  def initialize gene=nil
    raise(ArgumentError, "I need a numeric ID or a Gene object, not a string") if gene.is_a?(String)
    super
    Assignment.superfamily_ids(gene).each do |sid|
      gene_id = gene.is_a?(Gene) ? gene.id : gene
      self[sid] = DocVector.tf_idf(gene_id, sid)
    end
  end

  # Default value for a queried value is 0.
  def [] superfamily_id
    if has_key?(superfamily_id)
      super superfamily_id
    else
      0
    end
  end

  # The total number of assignments in a hash
  def count
    @count ||= self.each_value.inject { |sum,n| sum + n }
  end

  # Dot product this hash with another
  def dot rhs
    # raise(ArgumentError, "rhs must be a document vector") unless rhs.is_a?(DocVector)
    (self.keys | rhs.keys).inject(0) do |memo,key|
      memo + (self[key] * rhs[key])
    end
  end

  # Get the scalar length of this vector
  def length
    Math.sqrt( self.keys.inject(0){ |memo,k| memo + self[k]**2 }.to_f )
  end

  # Give the similarity between this vector and q
  def similarity q
    (self.dot(q)) / (self.length * q.length)
  end

  # Frequency of a superfamily assignment in a gene:
  # Number of occurrences of assignment ti in gene dj
  # divided by
  # total number of assignments in the gene
  def self.tf(gene_id, superfamily_id)
    # STDERR.puts("gene id is #{gene_id}")
    Assignment.count_occurrences_of_assignment_in_gene(superfamily_id, gene_id) \
      / Assignment.assignment_counts_by_gene(gene_id).to_f
  end

  def self.tf_idf(gene_id, superfamily_id)
    DocVector.tf(gene_id, superfamily_id) / Assignment.idf(superfamily_id).to_f
  end

end
