class CreateExamApplicationFormStudents < ActiveRecord::Migration
  def change
    create_table :exam_application_form_students do |t|
      t.integer :mg_student_id
      t.integer :mg_exam_application_form_data_id
      t.string :is_deleted=
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
