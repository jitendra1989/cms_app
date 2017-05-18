class RenameColumnInSubject < ActiveRecord::Migration
  def change
  	rename_column :mg_subjects, :mg_elective_type_id, :mg_elective_group_id
  end
end
