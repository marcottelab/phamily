
def normalize_species sp
  sp = 'ce' if sp == 'cl'
  sp.capitalize
end


#load_assignments.rake
namespace :db do
  desc "load family and superfamily assignments from csv"
  task :load_assignments  => :environment do

    DATA_DIR = "data/"
    Dir.foreach("data") do |file|

      next unless file =~ /SUPERFAMILY_domains\.txt$/

      FasterTSV.foreach("#{DATA_DIR}#{file}", :col_sep => "\t") do |row|
        Assignment.create!(:species => normalize_species(row[0]), :row_id => row[1], :model_id => row[2].to_i,
			  :region => row[3], :e_value => row[4].to_f, :superfamily_id => row[5].to_i,
			  :superfamily_desc => row[6], :family_e_value => row[7].to_f, :family_id => row[8].to_i,
			  :family_desc => row[9], :most_similar_structure => row[10])
      end
    end
  end  
end
