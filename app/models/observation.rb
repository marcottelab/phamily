class Observation < ActiveRecord::Base
  belongs_to :gene
  belongs_to :phenotype
end
