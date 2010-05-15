#prior_sfsimilarity_given_orthology.rake

namespace :prob do
  namespace :prior do
    desc "output a table of known (INPARANOID) orthologs and their cosine similarity scores (which are based on SUPERFAMILY assignments)"
    task :orthology_given_sfsimilarity, :from, :to, :needs => :environment do |t,args|
      args.with_defaults(:to => "Hs")

      raise ArgumentError, "Needs at least one argument (from-species, e.g., 'Mm')" if args.from.nil?

      DATA_DIR = Rails.root + "data/out"
      Dir.chdir(DATA_DIR) do
        filename = "sfsimilarity_given_orthology.#{args.to}#{args.from}.tab"

        
        orthopairs = Orthogroup.orthologs_by_species_pair(args.to, args.from)

        puts "Calculating doc vectors and writing file..."
        f = File.new(filename, 'w')

        g_dv = {}
        h_dv = {}
        orthopairs.each do |orthopair|
          # Calculate document vectors for genes in the orthopair
          unless g_dv.has_key?(orthopair.g_original_id)
            g_to_dv = DocVector.new(orthopair.g_id.to_i)
            g_dv[orthopair.g_original_id] = g_to_dv
          end

          unless h_dv.has_key?(orthopair.h_original_id)
            h_to_dv = DocVector.new(orthopair.h_id.to_i)
            h_dv[orthopair.h_original_id] = h_to_dv
          end
          # , dvlen = #{g_dv[orthopair.g_original_id].length}, #{h_dv[orthopair.h_original_id].length}
          STDERR.puts("gene ids = #{orthopair.g_id}, #{orthopair.h_id}")

          # Calculate the similarity between the two doc vectors.
          sim = g_dv[orthopair.g_original_id].similarity( h_dv[orthopair.h_original_id] )

          f.puts "#{orthopair.g_original_id}\t#{orthopair.h_original_id}\t#{orthopair.rank}\t#{orthopair.score}\t#{orthopair.g_confidence}\t#{orthopair.h_confidence}\t#{sim}"
        end

        puts "Finished, closing file."

        f.close
      end
    end
  end
end
