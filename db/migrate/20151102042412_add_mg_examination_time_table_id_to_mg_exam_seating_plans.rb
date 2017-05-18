class AddMgExaminationTimeTableIdToMgExamSeatingPlans < ActiveRecord::Migration
  def change
    add_column :mg_exam_seating_plans, :mg_examination_time_table_id, :integer
  end
end
