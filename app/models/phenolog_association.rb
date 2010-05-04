class PhenologAssociation < ActiveRecord::Base
  belongs_to :phenotype
  belongs_to :phenolog
end