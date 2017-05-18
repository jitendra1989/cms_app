class MgInstituteRoom < ActiveRecord::Base
	belongs_to :mg_employee_specialization
	has_many :mg_subjects
	has_many :mg_time_table_entries
end
