class AddFileStatusToMgDocumentManagement < ActiveRecord::Migration
  def change
    add_column :mg_document_managements, :file_status, :boolean
  end
end
