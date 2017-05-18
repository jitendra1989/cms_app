class AddMgBatchIdToMgExaminationTimeTables < ActiveRecord::Migration
  def change
    add_column :mg_examination_time_tables, :mg_batch_id, :integer
  end
end
