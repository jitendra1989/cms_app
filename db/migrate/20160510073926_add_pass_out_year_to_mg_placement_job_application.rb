class AddPassOutYearToMgPlacementJobApplication < ActiveRecord::Migration
  def change
    add_column :mg_placement_job_applications, :pass_out_year, :string
  end
end
