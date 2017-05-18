class AddMgTimeTableIdToMgPlacementJobApplication < ActiveRecord::Migration
  def change
    add_column :mg_placement_job_applications, :mg_time_table_id, :integer
  end
end
