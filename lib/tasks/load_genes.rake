#load_genes.rake

def batch_insert_genes species, arr
  gene_data = arr.collect{|a| "('#{species}', '#{a}')"}
  sql = "INSERT INTO genes (original_id, species) VALUES " + gene_data.join(", ") + ";"
  ActiveRecord::Base.connection.execute sql
end

namespace :db do
  namespace :phenologs do
    desc "load genes from phenologs.org tables"
    task :load_genes => :environment do

      DATA_DIR = Rails.root + "data/"
      Dir.foreach(DATA_DIR) do |file|

        next unless file =~ /^genes\.[A-Z][a-z]$/

        sp = file[6..8]
        raise(Error, "Species not recognizable") unless sp =~ /^[A-Z][a-z]$/

        genes = []

        f = File.new("#{DATA_DIR}#{file}", "r")
        while line = f.gets
          line.chomp!
          genes << line
        end

        batch_insert_genes(sp, genes)
      end
    end
  end
end
