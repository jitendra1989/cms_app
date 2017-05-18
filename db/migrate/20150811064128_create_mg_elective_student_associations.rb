class CreateMgElectiveStudentAssociations < ActiveRecord::Migration
  def change
    create_table :mg_elective_student_associations do |t|
      t.integer :mg_elective_group_id
      t.integer :mg_student_id
      t.integer :mg_school_id
      t.boolean :is_deleted
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
