class AddStartDateAndEndDateToMgExaminationDetails < ActiveRecord::Migration
  def change
    add_column :mg_examination_details, :start_date, :date
    add_column :mg_examination_details, :end_date, :date
  end
end
