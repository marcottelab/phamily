#load_genes.rake
namespace :db do
  desc "load gene identifiers used in INPARANOID and map by alias"
  task :load_gene_aliases => :environment do

    DATA_DIR = Rails.root + "data/"
    Dir.foreach(DATA_DIR) do |file|

      next unless file =~ /^gene_translation\.[A-Z][a-z]$/

      sp = file[17..19]
      raise(Error, "Species not recognizable") unless sp =~ /^[A-Z][a-z]$/

      FasterTSV.foreach("#{DATA_DIR}#{file}", :col_sep => "\t", :ignore_header_lines => 1) do |row|
        Assignment.update_all( "original_id = '#{row[1]}'", ["species = ? AND row_id = ?", sp, row[0]] ) unless row.size < 2 || row[1].nil? || row[1].size == 0
      end
    end

  end
end
