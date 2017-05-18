class AddMgUserIdToMgEmployeeQuestionPaper < ActiveRecord::Migration
  def change
    add_column :mg_employee_question_papers, :mg_user_id, :integer
  end
end
