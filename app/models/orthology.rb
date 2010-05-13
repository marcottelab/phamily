class Orthology < ActiveRecord::Base
  belongs_to :orthogroup
  belongs_to :gene
end
