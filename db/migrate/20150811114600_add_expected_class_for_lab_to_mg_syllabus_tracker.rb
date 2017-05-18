class AddExpectedClassForLabToMgSyllabusTracker < ActiveRecord::Migration
  def change
    add_column :mg_syllabus_trackers, :expected_class_for_practical, :integer
  end
end
