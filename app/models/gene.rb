class Gene < ActiveRecord::Base
  has_and_belongs_to_many :phenotypes, :join_table => :observations, :uniq => true

  after_save :update_phenotypes_counter_cache

  def update_phenotypes_counter_cache
    self.phenotypes.each { |c| c.update_count(self) } unless self.phenotypes.empty?
  end

  def update_count
    update_attribute(:phenotypes_count, self.phenotypes.count)
  end
end
