class AddIsDeletedToExamApplicationFormStudent < ActiveRecord::Migration
  def change
    add_column :exam_application_form_students, :is_deleted, :boolean
  end
end
