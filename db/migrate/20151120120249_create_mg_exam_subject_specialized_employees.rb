class CreateMgExamSubjectSpecializedEmployees < ActiveRecord::Migration
  def change
    create_table :mg_exam_subject_specialized_employees do |t|
      t.integer :mg_examination_detail_id
      t.integer :mg_subject_id
      t.integer :mg_employee_id
      t.integer :mg_time_table_id
      t.integer :mg_course_id
      t.integer :mg_wing_id
      t.integer :mg_batch_id
      t.integer :mg_exam_type_id
      t.integer :mg_examination_category_id
      t.integer :mg_examination_program_category_id
      t.integer :mg_employee_specialization_id
      t.date :date
      t.time :start_time
      t.time :end_time


      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end
end
