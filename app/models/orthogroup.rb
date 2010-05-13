class Orthogroup < ActiveRecord::Base
  has_many :orthologies
  has_many :genes, :through => :orthologies
end
