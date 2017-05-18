class AddMgWingIdToMgPlacementJobApplication < ActiveRecord::Migration
  def change
    add_column :mg_placement_job_applications, :mg_wing_id, :integer
    add_column :mg_placement_job_applications, :mg_interview_round_id, :integer
    add_column :mg_placement_job_applications, :next_round_date, :date
    add_column :mg_placement_job_applications, :is_round_selected, :boolean
    add_column :mg_placement_job_applications, :round1, :integer
    add_column :mg_placement_job_applications, :round1_date, :date
    add_column :mg_placement_job_applications, :round2, :integer
    add_column :mg_placement_job_applications, :round2_date, :date
    add_column :mg_placement_job_applications, :round3, :integer
    add_column :mg_placement_job_applications, :round3_date, :date
    add_column :mg_placement_job_applications, :round4, :integer
    add_column :mg_placement_job_applications, :round4_date, :date
    add_column :mg_placement_job_applications, :round5, :integer
    add_column :mg_placement_job_applications, :round5_date, :date
    add_column :mg_placement_job_applications, :round6, :integer
    add_column :mg_placement_job_applications, :round6_date, :date
    add_column :mg_placement_job_applications, :round7, :integer
    add_column :mg_placement_job_applications, :round7_date, :date
    add_column :mg_placement_job_applications, :round8, :integer
    add_column :mg_placement_job_applications, :round8_date, :date
    add_column :mg_placement_job_applications, :round9, :integer
    add_column :mg_placement_job_applications, :round9_date, :date
    add_column :mg_placement_job_applications, :round10, :integer
    add_column :mg_placement_job_applications, :round10_date, :date


  end
end
