class AddIsHodToMgDocumentManagement < ActiveRecord::Migration
  def change
    add_column :mg_document_managements, :is_hod, :boolean
  end
end
