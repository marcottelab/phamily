#load_phenotype_columns.rake

namespace :db do
  namespace :phenologs do
    desc "load phenotype column ids for matrix"
    task :load_phenotype_columns => :environment do

      require 'dbi'

      species = ["xx", "Hs", "Mm", "Ce", "Sc", "At", "Dm", "Os"]

      dbh = DBI.connect('DBI:Pg:phenologdb_development', 'jwoods', 'youwish1')
      
      sth = dbh.prepare('select id,long_desc,species_id from phenotypes;')
      sth.execute
      
      while row = sth.fetch do
        if species[row[2]] == 'At'
          desc_exp = row[1].split(":")[2...row[1].size]
          p = Phenotype.find(:first, :conditions => {:desc => desc_exp, :species => species[row[2]]})
        else
          p = Phenotype.find(:first, :conditions => {:desc => row[1], :species => species[row[2]]})
        end
        
        if p.nil?
          STDERR.puts("Error: Phenotype with phenologdb_development id #{row[0]} was not found")
        else
          p.update_attribute(:column_id, row[0])
        end
      end
      
    end
  end
end
