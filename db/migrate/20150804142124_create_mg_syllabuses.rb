class CreateMgSyllabuses < ActiveRecord::Migration
  def change
    create_table :mg_syllabuses do |t|
      t.integer :mg_timetable_id
      t.integer :mg_wing_id
      t.integer :mg_course_id
      t.integer :mg_subject_id
      t.integer :mg_curriculum_grade_id
      t.integer :mg_curriculum_course_id
      t.string :name
      t.text :description
      t.boolean :is_deleted
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
