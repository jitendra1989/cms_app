class AddMgUserIdToMgPlacementJobUpload < ActiveRecord::Migration
  def change
  	add_column :mg_placement_job_uploads, :mg_user_id, :integer
  end
end
