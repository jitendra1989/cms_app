class AddMgEmployeeIdToMgExaminationHodLogin < ActiveRecord::Migration
  def change
    add_column :mg_examination_hod_logins, :mg_employee_id, :integer
  end
end
