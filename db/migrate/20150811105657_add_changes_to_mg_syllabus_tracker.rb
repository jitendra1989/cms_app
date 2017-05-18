class AddChangesToMgSyllabusTracker < ActiveRecord::Migration
  def change
    add_column :mg_syllabus_trackers, :mg_timetable_id, :integer
    add_column :mg_syllabus_trackers, :mg_wing_id, :integer
    add_column :mg_syllabus_trackers, :mg_course_id, :integer
    add_column :mg_syllabus_trackers, :mg_subject_id, :integer
    add_column :mg_syllabus_trackers, :mg_curriculum_grade_id, :integer
  end
end
