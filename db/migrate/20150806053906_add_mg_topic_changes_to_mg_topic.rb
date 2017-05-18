class AddMgTopicChangesToMgTopic < ActiveRecord::Migration
  def change
    add_column :mg_topics, :mg_timetable_id, :integer
    add_column :mg_topics, :mg_wing_id, :integer
    add_column :mg_topics, :mg_course_id, :integer
    add_column :mg_topics, :mg_subject_id, :integer
    add_column :mg_topics, :mg_curriculum_grade_id, :integer
    add_column :mg_topics, :time_alloted_for_practical, :integer
    add_column :mg_topics, :is_project_work, :boolean
  end
end
