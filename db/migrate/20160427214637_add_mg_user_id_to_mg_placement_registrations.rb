class AddMgUserIdToMgPlacementRegistrations < ActiveRecord::Migration
  def change
    add_column :mg_placement_registrations, :mg_user_id, :int
  end
end
