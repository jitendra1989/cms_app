class AddTotalAmountToMgExamApplicationFormData < ActiveRecord::Migration
  def change
    add_column :mg_exam_application_form_data, :total_amount, :float
    add_column :mg_exam_application_form_data, :receipt_number, :string

  end
end
