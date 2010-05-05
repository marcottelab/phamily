module Ortholog
  module Superfamily

    
    def given_phenolog phenolog
      
    end

    def given_phenolog_genes

    end

    # Probability that genes i, j are orthologous given SUPERFAMILY assignments.
    # Note that this is not corrected at all for multiple testing!
    def self.given_gene_pair gene_pair
      accum = 1.0
      common_ids(gene_pair).each do |superfamily_id|
        accum *= (1.0 - common(gene_pair, superfamily_id).to_f * \
            correct(gene_pair[0], superfamily_id) * \
            correct(gene_pair[1], superfamily_id))
      end
      accum
    end

    # Indicator: 0 if genes have a superfamily, 1 if they do not
    # (GIVEN: Superfamily assignments are correct)
    def self.common gene_pair, superfamily_id
      (gene_pair[0].assignments.by_superfamily_id(superfamily_id) & gene_pair[1].assignments.by_superfamily_id(superfamily_id)).size > 0 ? 1 : 0
    end

    # Get the set of common superfamilies between two genes
    def self.common_ids gene_pair
      gene_pair[0].superfamily_ids_set & gene_pair[1].superfamily_ids_set
    end

    # Find the lowest e-value association between a gene and assignment and return
    # 1.0 - that (the prob it's correct)
    # Note that this is not corrected at all for multiple testing!
    def self.correct gene, superfamily_id
      best_assignment = gene.assignments.by_superfamily_id(superfamily_id).first
      # This is the best because it has the lowest e_value (if there are multiple)

      (1.0 - (best_assignment.e_value * gene.superfamily_ids_set.size))
    end


  end

end