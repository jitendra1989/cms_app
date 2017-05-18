class AddColumnMgElectiveGroupToMgTimeTableEntry < ActiveRecord::Migration
  def change
    add_column :mg_time_table_entries, :mg_elective_group_id, :integer
  end
end
