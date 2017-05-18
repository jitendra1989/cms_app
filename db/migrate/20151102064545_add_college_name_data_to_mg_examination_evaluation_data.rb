class AddCollegeNameDataToMgExaminationEvaluationData < ActiveRecord::Migration
  def change
    add_column :mg_examination_evaluation_data, :college_name_data, :string
  end
end
