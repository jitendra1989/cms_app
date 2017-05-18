class AddMgEmployeeQuestionPaperIdToMgDocumentManagement < ActiveRecord::Migration
  def change
    add_column :mg_document_managements, :mg_employee_question_paper_id, :integer
  end
end
