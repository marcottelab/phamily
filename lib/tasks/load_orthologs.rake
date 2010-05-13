#orthologs.rake
namespace :db do
  namespace :inparanoid do
    desc "load orthologs and orthogroups from INPARANOID output"
    task :load_orthologs => :environment do

      DATA_DIR = Rails.root + "data/"
      Dir.foreach(DATA_DIR) do |file|

        next unless file =~ /^sqltable\.[A-Z][a-z]\-[A-Z][a-z]$/

        species_pair = file.split(".")[1].split("-").join("")
        puts "#{file}: Species pair is '#{species_pair}'"


        orthogroup = nil

        f = File.new("#{DATA_DIR}#{file}", "r")
        while line = f.gets
          line.chomp!
          row = line.split("\t")

          # Only find an orthogroup if we don't currently have one. Otherwise,
          # use the one we found last time.
          if orthogroup.nil? || orthogroup.rank != row[0]
            orthogroup = Orthogroup.find_or_create!(species_pair, row[0].to_i, row[1].to_i)
          end

          # Find the gene if possible
          gene_original_id = row[4].locusize
          gene = Gene.find_by_original_id(gene_original_id)

          # Gene not found: create one
          gene = Gene.create!(:original_id => gene_original_id, :species => row[2].speciesize) if gene.nil?

          Orthology.find_or_create_from_inparanoid(orthogroup, gene, row[3].to_f)
        end
      end
    end
  end
end