class AddStudentParticularsToExamApplicationFormStudent < ActiveRecord::Migration
  def change
    add_column :exam_application_form_students, :student_particulars, :string
    add_column :exam_application_form_students, :amount, :float
  end
end
