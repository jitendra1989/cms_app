class AddMgSubjectIdToMgDocumentManagement < ActiveRecord::Migration
  def change
    add_column :mg_document_managements, :mg_subject_id, :integer
    add_column :mg_document_managements, :mg_course_id, :integer

  end
end
