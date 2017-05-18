class AddMgSubjectTypeIdToMgTimeTableChangeEntries < ActiveRecord::Migration
  def change
    add_column :mg_time_table_change_entries, :mg_subject_type_id, :integer
  end
end
