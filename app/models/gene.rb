class Gene < ActiveRecord::Base
  has_and_belongs_to_many :phenotypes, :join_table => :observations, :uniq => true

  def update_count
    update_attribute(:phenotypes_count, self.phenotypes.count)
  end
end
