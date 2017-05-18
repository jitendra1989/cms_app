class AddMgExaminationDetailIdToMgExamApplicationFormData < ActiveRecord::Migration
  def change
    add_column :mg_exam_application_form_data, :mg_examination_detail_id, :integer
  end
end
