class ChangeColumnIsActiveMgPlacementTrainingOffered < ActiveRecord::Migration
  def change
    change_column :mg_placement_training_offereds, :is_active, :string
  end
end
