class AddMgElectiveTypeIdToMgSubjects < ActiveRecord::Migration
  def change
    add_column :mg_subjects, :mg_elective_type_id, :integer
  end
end
