class RenamemgRoomIdInMgSubject < ActiveRecord::Migration
  def change
  	rename_column :mg_subjects, :mg_room_id, :mg_institute_room_id
  end
end
