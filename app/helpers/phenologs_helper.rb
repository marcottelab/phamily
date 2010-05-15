module PhenologsHelper

  def decimal_to_color d, base = :red
    d = 1.0 - d
    r = (base == :red ? d * 255 : 255).to_i
    g = (base == :green ? d * 255 : 255).to_i
    b = (base == :blue ? d * 255 : 255).to_i
    color_to_hex r,g,b
  end

  def color_to_hex r,g,b
    red   = r.to_s(16)
    green = g.to_s(16)
    blue  = b.to_s(16)

    red = "0" + red if r < 16
    green = "0" + green if g < 16
    blue = "0" + blue if b < 16

    '#' + "#{red}#{green}#{blue}"
  end

  # Take similarity table and print it as an html table
  def similarity_table_to_h similarity_table, options = {}
    opts = {
      :mode => :color # :numeric is other option
    }
    open_tags = '<table class="similarity">'

    to_gene_original_ids = similarity_table.to_genes
    from_gene_original_ids = similarity_table.from_genes
    middle_tags = similarity_table_header_row(to_gene_original_ids)

    from_gene_original_ids.each do |oid|
      middle_tags += "<tr><td class=\"gene\">#{oid}</td>"
      
      to_gene_original_ids.each do |pid|
        if similarity_table.has_pair?(pid,oid)
          sim = similarity_table.get_pair(pid,oid)
          if opts[:mode] == :color
            color = decimal_to_color(sim[0])
            if color == "#ffffff" 
              if sim[1]
                middle_tags += "<td>o</td>"
              else
                middle_tags += "<td/>"
              end
              
            else
              middle_tags += "<td bgcolor=\"#{color}\" title=\"#{sim[0]}\">"
              middle_tags += "o" if sim[1]
              middle_tags += "</td>"
            end
            
          else
            middle_tags += "<td>#{sim[0]}, #{sim[1]}</td>"
          end
          
        end
      end

      middle_tags += "</tr>"
    end

    close_tags = '</table>'

    open_tags + middle_tags + close_tags
  end

  def similarity_table_header_row gene_original_ids
    open_tags = '<tr class="gene_ids"><td/>'

    middle_tags = ""

    gene_original_ids.each do |oid|
      middle_tags += "<td class=\"gene\">#{oid}</td>"
    end

    close_tags = '</tr>'

    open_tags + middle_tags + close_tags
  end

end
