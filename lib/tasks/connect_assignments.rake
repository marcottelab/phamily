#connect_assignments.rake
namespace :db do
  desc "connect genes and assignments by populating the gene_id column in assignments"
  task :connect_assignments  => :environment do

    assignment_gene_id = {}
    ActiveRecord::Base.connection.select_rows("SELECT a.id as assignment_id, g.id as gene_id FROM assignments a INNER JOIN genes g ON (a.original_id = g.original_id)").each do |row|
      assignment_gene_id[row[0]] = row[1]
    end

    assignment_gene_id.each_pair do |id,gene_id|
      Assignment.find(id).update_attribute(:gene_id, gene_id)
    end
  end
end