class AddNoOfStudentsOptedToMgSubjects < ActiveRecord::Migration
  def change
    add_column :mg_subjects, :no_of_students_opted, :integer
  end
end
