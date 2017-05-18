class AddMgSchoolIdToMgSyllabus < ActiveRecord::Migration
  def change
    add_column :mg_syllabuses, :mg_school_id, :integer
  end
end
