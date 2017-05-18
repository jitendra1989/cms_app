	class AddStatusToMgPlacementRegistrations < ActiveRecord::Migration
  def change
    add_column :mg_placement_registrations, :status, :string
  end
end
