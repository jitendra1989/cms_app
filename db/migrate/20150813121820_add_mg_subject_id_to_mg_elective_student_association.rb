class AddMgSubjectIdToMgElectiveStudentAssociation < ActiveRecord::Migration
  def change
    add_column :mg_elective_student_associations, :mg_subject_id, :integer
  end
end
