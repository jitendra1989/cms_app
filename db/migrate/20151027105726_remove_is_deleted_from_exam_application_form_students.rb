class RemoveIsDeletedFromExamApplicationFormStudents < ActiveRecord::Migration
  def change
    remove_column :exam_application_form_students, :is_deleted=, :string
  end
end
