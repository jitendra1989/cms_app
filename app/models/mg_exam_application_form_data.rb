class MgExamApplicationFormData < ActiveRecord::Base
  #validates :mg_examination_detail_id,:mg_batch_id, :uniqueness => {:scope => [:mg_school_id]},:condition ->{where()}
 #  validates_uniqueness_of :mg_examination_detail_id,
 #  scope: :mg_school_id,  
 #  conditions: -> { where(is_deleted: false) },on: :create

 # validates_uniqueness_of :mg_batch_id,
 #  scope: :mg_school_id,  
 #  conditions: -> { where(is_deleted: false) },on: :create
end
