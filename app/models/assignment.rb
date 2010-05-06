class Assignment < ActiveRecord::Base
  belongs_to :gene

  named_scope :by_superfamily_id, lambda { |sid| { :conditions => ['superfamily_id = ?', sid], :order => 'e_value'}}

  # Generate a hash from superfamily_id to bitvector index
  def self.bitvector_hash
    @@bitvector_hash ||= Assignment.bitvector_hash_internal
  end
protected
  def self.bitvector_hash_internal
    
  end
end
