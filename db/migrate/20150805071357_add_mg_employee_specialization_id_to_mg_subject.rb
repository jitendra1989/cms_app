class AddMgEmployeeSpecializationIdToMgSubject < ActiveRecord::Migration
  def change
    add_column :mg_subjects, :mg_employee_specialization_id, :integer
  end
end
