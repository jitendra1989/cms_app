class CreateMgCurriculumDocuments < ActiveRecord::Migration
  def change
    create_table :mg_curriculum_documents do |t|
      t.integer :mg_timetable_id
      t.integer :mg_wing_id
      t.integer :mg_course_id
      t.integer :mg_subject_id
      t.integer :mg_curriculum_grade_id
      t.integer :mg_syllabus_id
      t.integer :mg_unit_id
      t.integer :mg_topic_id
      t.integer :mg_nature_of_document_id
      t.date :until_date
      t.boolean :is_sharable
      t.text :keywords
      t.integer :mg_employee_id
      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
