class CreateMgPlacementShortListStudents < ActiveRecord::Migration
  def change
    create_table :mg_placement_short_list_students do |t|
      t.integer :mg_placement_registration_id
      t.integer :mg_placement_job_upload
      t.integer :mg_wing_id
      t.integer :mg_batch_id
      t.integer :mg_interview_round_id
      t.date :next_round_date
      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
