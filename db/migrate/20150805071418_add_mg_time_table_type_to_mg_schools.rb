class AddMgTimeTableTypeToMgSchools < ActiveRecord::Migration
  def change
    add_column :mg_schools, :mg_timetable_type, :string
  end
end
