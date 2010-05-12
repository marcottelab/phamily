#generate_matrix.rake
desc "generate a matrix of tf-idf scores for each pair of genes, provided genes are from separate species"
task :generate_matrix, :from, :to, :needs => :environment do |t,args|
  args.with_defaults(:to => "Hs")

  raise ArgumentError, "Needs at least one argument (from-species, e.g., 'Mm')" if args.from.nil?

  to_genes   = Gene.find_all_by_species(args.to)
  from_genes = Gene.find_all_by_species(args.from)

  g_dv = {}
  h_dv = {}

  to_genes.each do |g|
    g_to_dv = g.to_dv
    g_dv[g.original_id] = g_to_dv unless g_to_dv.empty?
  end

  from_genes.each do |h|
    h_to_dv = h.to_dv
    h_dv[h.original_id] = h_to_dv unless h_to_dv.empty?
  end

  puts "Writing file..."
  f = File.new("tf_idf_matrix.#{args.to}#{args.from}", 'w')

  g_dv.keys.sort.each do |gid|
    gdv = g_dv[gid]

    h_dv.keys.sort.each do |hid|
      hdv = h_dv[hid]
      f.puts "#{gid}\t#{hid}\t#{gdv.similarity(hdv)}"
    end
  end
  
  puts "Finished, closing file."

  f.close
end
