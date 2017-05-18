class AddMgUnitChangesToMgUnit < ActiveRecord::Migration
  def change
    add_column :mg_units, :mg_timetable_id, :integer
    add_column :mg_units, :mg_wing_id, :integer
    add_column :mg_units, :mg_course_id, :integer
    add_column :mg_units, :mg_subject_id, :integer
    add_column :mg_units, :mg_curriculum_grade_id, :integer
  end
end
