class CreateMgPlacementJobApplications < ActiveRecord::Migration
  def change
    create_table :mg_placement_job_applications do |t|
      t.integer :mg_placement_registration_id
      t.integer :mg_job_upload_id
      t.integer :mg_document_management_id
      t.integer :mg_student_id
      t.integer :mg_batch_id
      t.integer :is_deleted
      t.integer :created_by
      t.integer :updated_by
      t.integer :mg_school_id

      t.timestamps
    end
  end
end
