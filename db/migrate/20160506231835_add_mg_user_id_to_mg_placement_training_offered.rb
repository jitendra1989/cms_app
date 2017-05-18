class AddMgUserIdToMgPlacementTrainingOffered < ActiveRecord::Migration
  def change
  	add_column :mg_placement_training_offereds, :mg_user_id, :integer
  end
end
