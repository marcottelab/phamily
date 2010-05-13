# Tries to figure out how to properly parse a locus identifier.
class LocusNom

  # Given a locus string, parse it as best we can.
  def initialize str
    @original = str
    if str =~ /^[0-9]+\|NP_[0-9]+/
      @parsed = LocusNom.extract_entrez_from_inparanoid str
    elsif str =~ /^FBgn[0-9]+/
      @parsed = LocusNom.extract_flybase_gene_from_inparanoid str
    else # not recognized
      @parsed = str
    end
  end

  attr_reader :original
  attr_reader :parsed

protected
  def self.extract_entrez_from_inparanoid str
    str.split("|")[0]
  end

  def self.extract_flybase_gene_from_inparanoid str
    str.split("-")[0] # attempt to split and discard the end
  end

end