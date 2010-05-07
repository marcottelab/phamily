# Describe genes as documents with assignments as words.
# You create one DocHash for each gene, and it has an entry for each assignment.
class DocVector < Hash

  # Given no gene, initialize as representing the entire set of available assignments
  # and their frequencies.
  #
  # Given a gene, initialize as containing only the assignments in that gene (and
  # 0 for every other assignment.
  def initialize gene=nil
    super
    Assignment.superfamily_ids(gene).each do |sid|
      self[sid] = gene.tf_idf(sid)
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

end
