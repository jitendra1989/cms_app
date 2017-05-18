class CreateMgExamApplicationStudentReceipts < ActiveRecord::Migration
  def change
    create_table :mg_exam_application_student_receipts do |t|
      t.integer :mg_exam_application_form_data_id
      t.integer :mg_student_id
      t.string :form_no
      t.boolean :is_deleted
      t.integer :mg_school_id
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
