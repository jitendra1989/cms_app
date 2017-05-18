class MgEntranceExamDetail < ActiveRecord::Base

  # validates :mg_course_id, :uniqueness =>{:scope=>[:mg_school_id,:is_deleted]}
  # validates :mg_course_id, :uniqueness => {:scope => "mg_school_id",:query_options => {:active => nil}}
  # validates_uniqueness_of :mg_course_id,  
  # scope: :mg_school_id,  
  # conditions: -> { where(is_deleted: false) }
end
