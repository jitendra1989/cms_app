class CreateMgExaminationMarksEvaluationData < ActiveRecord::Migration
  def change
    create_table :mg_examination_marks_evaluation_data do |t|
      t.integer :mg_examination_detail_id
      t.integer :mg_wing_id
      t.integer :mg_course_id
      t.integer :mg_subject_id
      t.string :max_marks
      t.date :date_of_marks_entry
      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
