class AddMgSubjectTypeIdToMgSubjects < ActiveRecord::Migration
  def change
    add_column :mg_subjects, :mg_subject_type_id, :integer
  end
end
