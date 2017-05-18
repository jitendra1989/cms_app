class CreateMgPlacementAcceptedTrainees < ActiveRecord::Migration
  def change
    create_table :mg_placement_accepted_trainees do |t|
      t.integer :mg_placement_training_offered_id
      t.integer :mg_student_id
      t.integer :mg_batch_id
      t.string :status
      t.integer :created_by
      t.integer :updated_by
      t.boolean :is_deleted
      t.integer :mg_school_id

      t.timestamps
    end
  end
end
