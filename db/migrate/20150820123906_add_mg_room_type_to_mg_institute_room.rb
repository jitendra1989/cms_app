class AddMgRoomTypeToMgInstituteRoom < ActiveRecord::Migration
  def change
    add_column :mg_institute_rooms, :mg_room_type, :string
  end
end
