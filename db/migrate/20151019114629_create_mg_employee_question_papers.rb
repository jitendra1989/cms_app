class CreateMgEmployeeQuestionPapers < ActiveRecord::Migration
  def change
    create_table :mg_employee_question_papers do |t|
      t.integer :mg_time_table_id
      t.integer :mg_wing_id
      t.integer :mg_course_id
      t.integer :mg_subject_id
      t.integer :mg_school_id
      t.boolean :is_deleted
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
