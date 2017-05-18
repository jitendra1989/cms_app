class AddMgInstituteRoomIdToMgTimeTableEntries < ActiveRecord::Migration
  def change
    add_column :mg_time_table_entries, :mg_institute_room_id, :integer
  end
end
