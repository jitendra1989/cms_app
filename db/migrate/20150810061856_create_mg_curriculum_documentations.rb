class CreateMgCurriculumDocumentations < ActiveRecord::Migration
  def change
    create_table :mg_curriculum_documentations do |t|
      t.integer :mg_employee_id
      t.integer :mg_curriculum_document_id
      t.integer :mg_school_id
      t.boolean :is_deleted
      t.string :user_type
      t.integer :created_by
      t.integer :updated_by
      t.attachment :file

      t.timestamps
    end
  end
end
