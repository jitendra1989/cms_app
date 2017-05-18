class AddClassTypeToMgSyllabusTrackers < ActiveRecord::Migration
  def change
    add_column :mg_syllabus_trackers, :class_type, :string
  end
end
