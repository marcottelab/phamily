class Assignment < ActiveRecord::Base
  belongs_to :gene

  named_scope :by_superfamily_id, lambda { |sid| { :conditions => ['superfamily_id = ?', sid]}}
  default_scope :order => 'e_value'
end
