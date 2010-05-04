#load_phenotypes.rake

namespace :db do
  namespace :phenologs do
    desc "load distances between phenotypes"
    task :load_phenologs, :from, :to, :distance, :matrix_id, :experiment_id, :needs => :environment do |t,args|
      args.with_defaults(:distance => "hypergeometric", :matrix_id => 1, :experiment_id => 211, :to => 'Hs')

      #require 'dbi'
      
      #dbh = DBI.connect('DBI:Pg:phenologdb_development', 'jwoods', 'youwish1')

      Dir.chdir("../crossval/tmp/work/matrix_#{args.matrix_id}/experiment_#{args.experiment_id}/") do
        file_base = "genes_phenes.#{args.to}#{args.from}.no_id"
        overlapf  = File.new("#{file_base}.pcommon", "r")
        distancef = File.new("#{file_base}.hypergeometric.pdistances", "r")

        overlap  = {}
        distance = {}

        species_pair = "#{args.to}#{args.from}"

        count = 0

        while rec = overlapf.gets
          rec.chomp!
          row = rec.split "\t"
          next if row[0] == row[1]

          o = row[2].to_i
          overlap["#{row[0]}-#{row[1]}"] = o unless o < 2
        end

        while rec = distancef.gets
          rec.chomp!
          row = rec.split "\t"
          next if row[0] == row[1]

          d = row[2].to_f
          distance["#{row[0]}-#{row[1]}"] = d unless d > 1E-4 || !overlap.has_key?("#{row[0]}-#{row[1]}")
        end

        puts "Creating objects"
        distance.each_pair do |k,dist|
          ids = k.split("-")
          p1 = Phenotype.find(:first, :conditions => {:column_id => ids[0].to_i})
          p2 = Phenotype.find(:first, :conditions => {:column_id => ids[1].to_i})

          # Note that this doesn't notify if p1 and p2 were not found.
          unless p1.nil? || p2.nil?
            next if p1.species == p2.species
            
            phenolog = Phenolog.create!(:distance => dist, :overlap => overlap[k], :species_pair => species_pair)
            PhenologAssociation.create!(:phenolog_id => phenolog.id, :phenotype_id => p1.id)
            PhenologAssociation.create!(:phenolog_id => phenolog.id, :phenotype_id => p2.id)
          end
        end
      end
      
    end
  end
end
