class CreateMgExaminationEvaluationData < ActiveRecord::Migration
  def change
    create_table :mg_examination_evaluation_data do |t|
      t.integer :mg_examination_detail_id
      t.date :date_of_evaluation
      t.string :examiner_name
      t.integer :mg_wing_id
      t.integer :mg_course_id
      t.integer :mg_subject_id
      t.integer :college_name
      t.string :copies
      t.integer :created_by
      t.integer :updated_by
      t.boolean :is_deleted
      t.integer :mg_school_id

      t.timestamps
    end
  end
end
