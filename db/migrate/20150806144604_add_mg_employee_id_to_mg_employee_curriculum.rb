class AddMgEmployeeIdToMgEmployeeCurriculum < ActiveRecord::Migration
  def change
    add_column :mg_employee_curriculums, :mg_employee_id, :integer
  end
end
