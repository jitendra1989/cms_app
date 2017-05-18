class AddMgWingIdAndMgCourseIdToMgExaminationTimeTables < ActiveRecord::Migration
  def change
    add_column :mg_examination_time_tables, :mg_wing_id, :integer
    add_column :mg_examination_time_tables, :mg_course_id, :integer
  end
end
