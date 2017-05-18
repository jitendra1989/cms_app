class AddAuditFieldsToMgCceReport < ActiveRecord::Migration
  def change
  	add_column :mg_cce_reports, :is_deleted, :boolean
  	add_column :mg_cce_reports, :mg_school_id, :integer
  	add_column :mg_cce_reports, :created_by, :integer
  	add_column :mg_cce_reports, :updated_by, :integer
  end
end
