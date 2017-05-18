class CreateMgExamSeatingPlanDetails < ActiveRecord::Migration
  def change
    create_table :mg_exam_seating_plan_details do |t|
      t.integer :mg_exam_seating_plan_id
      t.integer :mg_wing_id
      t.integer :mg_course_id
      # t.integer :mg_subject_id
      t.integer :mg_student_id
      
      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end
  end
end
