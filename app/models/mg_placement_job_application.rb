class MgPlacementJobApplication < ActiveRecord::Base
	validates_uniqueness_of :mg_job_upload_id,  
  		scope: [:mg_school_id,:mg_student_id,:pass_out_year],
  		conditions: -> { where(is_deleted: false) }
end
