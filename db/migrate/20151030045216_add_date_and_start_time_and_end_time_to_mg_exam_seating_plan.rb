class AddDateAndStartTimeAndEndTimeToMgExamSeatingPlan < ActiveRecord::Migration
  def change
    add_column :mg_exam_seating_plans, :date, :date
    add_column :mg_exam_seating_plans, :start_time, :time
    add_column :mg_exam_seating_plans, :end_time, :time
  end
end
