class AddStatusToMgPlacementTrainingOffered < ActiveRecord::Migration
  def change
    add_column :mg_placement_training_offereds, :status, :string
    add_column :mg_placement_training_offereds, :is_active, :boolean

  end
end
