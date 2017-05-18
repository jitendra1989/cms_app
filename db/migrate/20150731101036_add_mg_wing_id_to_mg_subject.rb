class AddMgWingIdToMgSubject < ActiveRecord::Migration
  def change
    add_column :mg_subjects, :mg_wing_id, :integer
  end
end
