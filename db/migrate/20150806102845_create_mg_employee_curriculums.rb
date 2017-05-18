class CreateMgEmployeeCurriculums < ActiveRecord::Migration
  def change
    create_table :mg_employee_curriculums do |t|
      t.integer :mg_timetable_id
      t.integer :mg_wing_id
      t.integer :mg_course_id
      t.integer :mg_subject_id
      t.integer :mg_curriculum_grade_id
      t.integer :mg_syllabus_id
      t.string :status
      t.text :comments
      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
