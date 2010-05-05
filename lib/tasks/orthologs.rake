#orthologs.rake

desc "load phenotypes and phenotype descriptions from phenologs.org tables"
task :load_phenotypes => :environment do

  DATA_DIR = Rails.root + "data/"
  Dir.foreach(DATA_DIR) do |file|

    next unless file =~ /^PhenotypeDescriptions_[A-Z][a-z]/

    f = File.new("#{DATA_DIR}#{file}", "r")
    while line = f.gets
      line.chomp!
      row = line.split("\t")
      sp = row[0][0..1]

      Phenotype.create!(:species => sp, :original_id => row[0], :desc => row[1])
    end
  end
end
