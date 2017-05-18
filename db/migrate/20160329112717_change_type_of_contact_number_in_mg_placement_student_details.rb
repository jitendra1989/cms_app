class ChangeTypeOfContactNumberInMgPlacementStudentDetails < ActiveRecord::Migration
  def change
  	change_column :mg_placement_student_details, :contact_number, :integer,:limit => 8
  end
end
