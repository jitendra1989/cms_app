class AddColumnReasonToMgPlacementRegistration < ActiveRecord::Migration
  def change
    add_column :mg_placement_registrations, :reason, :text
  end
end
