class Assignment < ActiveRecord::Base
  belongs_to :gene

  named_scope :by_superfamily_id, lambda { |sid| { :conditions => ['superfamily_id = ?', sid], :order => 'e_value'}}
  named_scope :genes_with_assignment_counts_plus_one, :select => 'DISTINCT gene_id, count(superfamily_id)', :group => "gene_id HAVING count(superfamily_id)>=1"

  named_scope :assignment_counts_by_superfamily_plus_one, lambda { |sid| { :select => 'DISTINCT gene_id, count(superfamily_id)', :group => "gene_id HAVING count(superfamily_id)>=1", :conditions => ["superfamily_id = ?", sid]} }
  named_scope :assignment_counts_by_gene_, lambda { |gid| {:select => 'DISTINCT gene_id, count(superfamily_id)', :group => "gene_id HAVING count(superfamily_id)>=1", :conditions => ["gene_id = ?", gid]} }
  named_scope :assignment_counts_by_gene_and_superfamily_, lambda { |gid,sid| {:select => 'DISTINCT gene_id, count(superfamily_id)', :group => "gene_id HAVING count(superfamily_id)>=1", :conditions => ["gene_id = ? AND superfamily_id = ?", gid, sid]} }


  def self.idf(superfamily_id)
    Math.log(Gene.count_with_assignments / Assignment.genes_by_assignment(superfamily_id).size.to_f)
  end


  def self.assignment_counts_by_gene gid
    row = Assignment.assignment_counts_by_gene_(gid)
    row.size == 0 ? 0 : row[0].count
  end


  def self.genes_with_assignment_counts
    g = Assignment.genes_with_assignment_counts_plus_one
    g.pop
    g
  end

  def self.genes_by_assignment(superfamily_id)
    g = Assignment.assignment_counts_by_superfamily_plus_one(superfamily_id)
    g.pop
    g
  end

  def self.count_occurrences_of_assignment_in_gene(superfamily_id, gene_id)
    Assignment.assignment_counts_by_gene_and_superfamily_(gene_id, superfamily_id).size
  end

  # Return all superfamily ids in a fast select. Allow the user to supply a gene, optionally.
  def self.uniq_superfamily_ids gene=nil
    if gene.nil?
      sql = "SELECT DISTINCT superfamily_id FROM assignments "
    else
      gene = gene.id if gene.is_a?(Gene)

      if gene.is_a?(Fixnum)
        sql += "WHERE gene_id = #{gene} "
      elsif gene.is_a?(String) && gene =~ /^[a-zA-Z0-9]*$/
        sql += "WHERE original_id = '#{gene}' "
      else
        raise ArgumentError, "If you provide an argument it needs to be a gene_id (integer), original_id (string), or a gene object"
      end
    end

    sql += "ORDER BY superfamily_id;"
    ActiveRecord::Base.connection.select_values(sql).collect { |s| s.to_i }
  end

  def self.superfamily_ids gene=nil
    sql = "SELECT superfamily_id FROM assignments "
    
    unless gene.nil?
      gene = gene.id if gene.is_a?(Gene)

      if gene.is_a?(Fixnum)
        sql += "WHERE gene_id = #{gene} "
      elsif gene.is_a?(String) && gene =~ /^[a-zA-Z0-9]*$/
        sql += "WHERE original_id = '#{gene}' "
      else
        raise ArgumentError, "If you provide an argument it needs to be a gene_id (integer), original_id (string), or a gene object"
      end
    end

    sql += "ORDER BY superfamily_id;"
    ActiveRecord::Base.connection.select_values(sql).collect { |s| s.to_i }
  end

end
