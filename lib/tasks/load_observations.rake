#load_observations.rake

namespace :db do
  namespace :phenologs do
    desc "load gene-phenotype observations from phenologs.org tables"
    task :load_observations => :environment do

      DATA_DIR = Rails.root + "data/"
      Dir.foreach(DATA_DIR) do |file|

        next unless file =~ /^PhenotypeDescriptions_[A-Z][a-z]/

        f = File.new("#{DATA_DIR}#{file}", "r")
        while line = f.gets
          line.chomp!
          row = line.split("\t")
          sp = row[0][0..2]
          gene_original_id = row[1].split(":")[1]

          phenotype_id = Phenotype.find(:first, :conditions => {:original_id => row[0]}).id
          gene_id      = Gene.find(:first, :conditions => {:original_id => gene_original_id}).id
          Observation.create!(:gene_id => gene_id, :phenotype_id => phenotype_id)
        end
      end
    end
  end
end
