class AddMgExaminationEvaluationIdToMgExaminationEvaluationData < ActiveRecord::Migration
  def change
    add_column :mg_examination_evaluation_data, :mg_examination_evaluation_id, :integer
  end
end
