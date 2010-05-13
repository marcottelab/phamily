class Orthogroup < ActiveRecord::Base
  has_many :orthologies, :dependent => :destroy
  has_many :genes, :through => :orthologies

  def self.find_or_create! species_pair, rank, score
    params = {:species_pair => species_pair, :score => score, :rank => rank}
    orthogroup = Orthogroup.find(:first, :conditions => params)
    orthogroup = Orthogroup.create!(params) if orthogroup.nil?
    orthogroup
  end
end
