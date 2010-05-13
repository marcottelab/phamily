class String

  # Convert the string to a species abbreviation
  def speciesize
    str = self.downcase
    if str =~ /mouse/ || str =~ /mus/ || str =~ /^mm$/
      'Mm'
    elsif str =~ /human/ || str =~ /homo/ || str =~ /sapiens/ || str =~ /^hs$/
      'Hs'
    elsif str =~ /arabidopsis/ || str =~ /thaliana/ || str =~ /^at$/
      'At'
    elsif str =~ /yeast/ || str =~ /saccharomyces/ || str =~ /cerev/ || str =~ /^sc$/
      'Sc'
    elsif str =~ /worm/ || str =~ /elegans/ || str =~ /^ce$/
      'Ce'
    elsif str =~ /oryza/ || str =~ /^os$/
      'Os'
    else
      self
    end
  end

  # Convert a string with multiple pieces of locus information into the correct
  # type of locus for phenologs
  def locusize
    LocusNom.new(self).parsed
  end
end