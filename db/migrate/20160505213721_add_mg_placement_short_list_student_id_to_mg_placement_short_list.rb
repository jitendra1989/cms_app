class AddMgPlacementShortListStudentIdToMgPlacementShortList < ActiveRecord::Migration
  def change
    add_column :mg_placement_short_lists, :mg_placement_short_list_student_id, :integer
  end
end
