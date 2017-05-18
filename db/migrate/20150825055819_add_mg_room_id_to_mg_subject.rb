class AddMgRoomIdToMgSubject < ActiveRecord::Migration
  def change
    add_column :mg_subjects, :mg_room_id, :integer
  end
end
