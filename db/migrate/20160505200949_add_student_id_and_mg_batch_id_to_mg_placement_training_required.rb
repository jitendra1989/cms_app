class AddStudentIdAndMgBatchIdToMgPlacementTrainingRequired < ActiveRecord::Migration
  def change
    add_column :mg_placement_training_requireds, :student_id, :integer
    add_column :mg_placement_training_requireds, :mg_batch_id, :integer
  end
end
