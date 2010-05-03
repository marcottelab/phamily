#load_observations.rake

namespace :db do
  namespace :phenologs do
    desc "load gene-phenotype observations from phenologs.org tables"
    task :load_observations => :environment do

      DATA_DIR = Rails.root + "data/"
      Dir.foreach(DATA_DIR) do |file|

        next unless file =~ /^phenotypes_[A-Z][a-z]$/

        f = File.new("#{DATA_DIR}#{file}", "r")
        while line = f.gets
          line.chomp!
          row = line.split("\t")
          gene_original_id = row[1].split(":")[1]
          sp  = file[11..12]

          STDERR.puts("Phenotype id is #{row[0]}, gene id is #{gene_original_id}")
          phenotype_id = Phenotype.find(:first, :conditions => {:original_id => row[0]}).id
          gene         = Gene.find(:first, :conditions => {:original_id => gene_original_id})
          gene         = Gene.create(:original_id => gene_original_id, :species => sp) if gene.nil?
          Observation.create!(:gene_id => gene.id, :phenotype_id => phenotype_id)
        end
      end
    end
  end
end
