class CreateMgExaminationStudentMarks < ActiveRecord::Migration
  def change
    create_table :mg_examination_student_marks do |t|
      t.integer :mg_examination_marks_evaluation_data_id
      t.integer :mg_student_id
      t.integer :mg_grading_level_id
      t.float :marks_obtained
      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
