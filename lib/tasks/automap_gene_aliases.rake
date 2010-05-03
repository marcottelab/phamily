#automap_gene_aliases.rake

namespace :db do
  desc "map gene identifiers used in INPARANOID based on some sort of regex match"
  task :automap_gene_aliases => :environment do

    Assignment.find(:all, :conditions => {:species => 'At'}).each do |assignment|
      base_id = assignment.row_id.split(".")[0]
      #suffix  = assignment.row_id.split(".")[1]
      #while suffix !~ /^[0-9]+$/
      #  suffix = suffix[0...suffix.size-1]
      #end
      assignment.update_attribute(:original_id, base_id) #+ "." + suffix)
    end
    Assignment.update_all("original_id = row_id", "species = 'Sc'")

  end
end
