class AddIsDefaultInMgDocumentManagement < ActiveRecord::Migration
  def change
  	add_column :mg_document_managements, :is_default, :boolean
  end
end
