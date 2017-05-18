class AddJobSelectedToMgPlacementJobApplication < ActiveRecord::Migration
  def change
    add_column :mg_placement_job_applications, :job_selected, :boolean
  end
end
