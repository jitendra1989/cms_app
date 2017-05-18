class AddMgPlacementRegistrationIdToMgPlacementAcceptedTrainee < ActiveRecord::Migration
  def change
    add_column :mg_placement_accepted_trainees, :mg_placement_registration_id, :integer
  end
end
